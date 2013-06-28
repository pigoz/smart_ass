require "spec_helper"

describe SmartAss::YCbCrConverter do

  it "can mangle RGB doing RGB ->(bt601) YCbCr ->(b709) RGB" do
    bt601 = SmartAss::YCbCrConverter.new(:bt601)
    bt709 = SmartAss::YCbCrConverter.new(:bt709)

    yuv = bt601.to_ycbcr(16, 138, 187)
    rgb = bt709.to_rgb(*yuv)

    rgb.should =~ [5, 129, 191]
  end

  it "handles RGB -> BT601TV" do
    bt601 = SmartAss::YCbCrConverter.new(:bt601)
    yuv   = bt601.to_ycbcr(0, 0, 0)
    yuv.should =~ [16.0, 128.0, 128.0]
  end

  it "handles RGB -> BT709TV" do
    bt601 = SmartAss::YCbCrConverter.new(:bt709)
    yuv   = bt601.to_ycbcr(0, 0, 0)
    yuv.should =~ [16.0, 128.0, 128.0]
  end

  it "handles RGB -> BT709FULL" do
    bt601 = SmartAss::YCbCrConverter.new(:bt709, :full)
    yuv   = bt601.to_ycbcr(0, 0, 0)
    yuv.should =~ [0.0, 128.0, 128.0]
  end

end
