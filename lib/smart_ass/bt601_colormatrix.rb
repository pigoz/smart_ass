module SmartAss::BT601
  def initialize
    super(0.299, 0.587, 0.114)
  end
end

class SmartAss::BT601TVColorMatrix < SmartAss::YCbCrTVColorMatrix
  include SmartAss::BT601
end

class SmartAss::BT601FULLColorMatrix < SmartAss::YCbCrFULLColorMatrix
  include SmartAss::BT601
end
