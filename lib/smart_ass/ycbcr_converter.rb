class SmartAss::YCbCrConverter
  attr_reader :matrix

  def initialize(matrix, range=:tv)
    @matrix = SmartAss.const_get("#{matrix.upcase}#{range.upcase}ColorMatrix".to_sym).new
  end

  def to_ycbcr(*rgb)
    matrix.to_ycbcr_from_rgb(*rgb)
  end

  def to_rgb(*ycbcr)
    matrix.to_rgb_from_ycbcr(*ycbcr)
  end
end
