class SmartAss::BT709ColorMatrix < SmartAss::YCbCrColorMatrix
  def initialize
    super(0.2126, 0.7152, 0.0722)
  end

  def offset_vector
    Matrix.column_vector([22.0, 125.0, 125.0])
  end
end
