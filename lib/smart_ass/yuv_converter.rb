require 'matrix'

class SmartAss::YUVConverter
  def initialize(matrix)
    @matrix = matrix.upcase
  end

  def to_yuv(*rgb)
    convert(:to_yuv_matrix, rgb)
  end

  def to_rgb(*ycbcr)
    convert(:to_rgb_matrix, ycbcr)
  end

  def to_yuv!(*rgb)
    to_yuv(*rgb.map {|c| c.to_f / 255.0})
  end

  def to_rgb!(*ycbcr)
    to_rgb(*ycbcr).map {|c| (c*255.0).round }
  end

  private
  def convert(method, input_array)
    output_vector = k.public_send(method) * Matrix.column_vector(input_array)
    output_vector.to_a.flatten
  end

  def k
    self.class.const_get(@matrix).new
  end

  class BT601
    def wr; 0.299; end
    def wg; 0.587; end
    def wb; 0.114; end

    def to_rgb_matrix
      Matrix[
        [1.0,  0.0,      1.13983 ],
        [1.0, -0.39465, -0.58060 ],
        [1.0,  2.03211,  0.0     ]
      ]
    end

    def to_yuv_matrix
      Matrix[
        [ wr,       wg,       wb      ],
        [-0.14713, -0.28886,  0.436   ],
        [ 0.615,   -0.51499, -0.10001 ]
      ]
    end
  end

  class BT709
    def wr; 0.2126; end
    def wg; 0.7152; end
    def wb; 0.0722; end

    def to_rgb_matrix
      Matrix[
        [1.0,  0.0,      1.28033 ],
        [1.0, -0.21482, -0.38059 ],
        [1.0,  2.12798,  0.0     ]
      ]
    end

    def to_yuv_matrix
      Matrix[
        [ wr,       wg,       wb      ],
        [-0.09991, -0.33609,  0.436   ],
        [ 0.615,   -0.55861, -0.05639 ]
      ]
    end
  end
end
