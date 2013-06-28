module SmartAss::BT709
  def initialize
    super(0.2126, 0.7152, 0.0722)
  end
end

class SmartAss::BT709TVColorMatrix < SmartAss::YCbCrTVColorMatrix
  include SmartAss::BT709
end

class SmartAss::BT709FULLColorMatrix < SmartAss::YCbCrFULLColorMatrix
  include SmartAss::BT709
end
