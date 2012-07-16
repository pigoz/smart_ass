class SmartAss::BT601ColorMatrix < SmartAss::YCbCrColorMatrix
  def initialize
    super(0.299, 0.587, 0.114)
  end
end
