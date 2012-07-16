class SmartAss::BT709ColorMatrix < SmartAss::YCbCrColorMatrix
  def initialize
    super(0.2126, 0.7152, 0.0722)
  end
end
