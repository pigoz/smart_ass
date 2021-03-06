require 'matrix'

class SmartAss::YCbCrColorMatrix
  attr_reader :wr, :wg, :wb
  def initialize(wr, wg, wb)
    @wr, @wg, @wb = wr, wg, wb
  end

  # basic luma relation: converts R'G'B' -> Y'(B'-Y')(R'-Y')
  def to_ybmyrmy_matrix
    Matrix[
      [ wr,    wg,   wb   ],
      [-wr,   -wg,   wr+wg],
      [wg+wb, -wg,  -wb   ],
    ]
  end

  # RGB -> YPbPr []
  def to_ypbpr_matrix_from_rgb
    scale_rows to_ybmyrmy_matrix, 1.0, 0.5 / (wr+wg), 0.5 / (wg+wb)
  end

  # YPbPr -> RGB []
  def to_rgb_matrix_from_ypbpr
    to_ypbpr_matrix_from_rgb.inverse
  end

  # RGB -> YCbCr []
  def to_ycbcr_matrix_from_rgb
    scale_rows to_ypbpr_matrix_from_rgb, 219.0, 224.0, 224.0
  end

  # YCbCr -> RGB []
  def to_rgb_matrix_from_ycbcr
    to_ycbcr_matrix_from_rgb.inverse
  end

  # RGB(digital) -> YCbCr []
  def to_ycbcr_matrix_from_rgbd
    scale_rows to_ycbcr_matrix_from_rgb, *[1.0/255.0]*3
  end

  # YCbCr -> RGB(digital) []
  def to_rgbd_matrix_from_ycbcr
    to_ycbcr_matrix_from_rgbd.inverse
  end

  # RGB(digital) -> YCbCr Equation
  def to_ycbcr_from_rgb(*rgb)
    r = apply_equation(*rgb) do |*rgb|
      offset_vector + (to_ycbcr_matrix_from_rgbd * Matrix.column_vector(rgb))
    end

    clip_ycbcr(r)
  end

  # YCbCr -> RGB(digital) Equation
  def to_rgb_from_ycbcr(*ycbcr)
    r = apply_equation(*ycbcr) do |*ycbcr|
      to_rgbd_matrix_from_ycbcr * (Matrix.column_vector(ycbcr) - offset_vector)
    end.map(&:round)

    clip_rgb(r)
  end

  private
  def clip_rgb(input)
    input.map {|n| clip_component(n, 0, 255)}
  end

  def clip_ycbcr(input)
    [
      clip_component(input[0], *y_minmax),
      clip_component(input[1], *cbcr_minmax),
      clip_component(input[2], *cbcr_minmax)
    ]
  end

  def clip_component(c, min, max)
    if c < min
      min
    elsif c > max
      max
    else
      c
    end
  end

  def y_minmax
    [16.0, 235.0]
  end

  def cbcr_minmax
    [16.0, 240.0]
  end

  def offset_vector
    Matrix.column_vector([16.0, 128.0, 128.0])
  end

  def apply_equation(*inputs, &block)
    block.call(*inputs).to_a.flatten
  end

  def scale_rows(matrix, *factors)
    raise InvalidArgumentError unless matrix.row_size == factors.size
    Matrix[*factors.each_with_index.map{|factor, index|
      matrix.row(index) * factor
    }]
  end
end
