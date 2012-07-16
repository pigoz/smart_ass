class SmartAss::YCbCrConverter
  attr_reader :matrix

  def initialize(matrix)
    @matrix = SmartAss.const_get("#{matrix.upcase}ColorMatrix".to_sym).new
  end

  def to_ycbcr(*rgb)
    matrix.to_ycbcr_from_rgb(*rgb)
  end

  def to_rgb(*ycbcr)
    matrix.to_rgb_from_ycbcr(*ycbcr)
  end
end
