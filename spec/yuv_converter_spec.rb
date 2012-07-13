require "spec_helper"

describe SmartAss::YUVConverter do

  it "can mangle RGB doing bt601 -> b709" do
    bt601 = SmartAss::YUVConverter.new(:bt601)
    bt709 = SmartAss::YUVConverter.new(:bt709)

    yuv = bt601.to_yuv!(16, 138, 187)
    rgb = bt709.to_rgb!(*yuv)

    rgb.should =~ [5, 129, 191]
  end

end
