require "spec_helper.rb"

describe SmartAss::RGBAColor do

  it "holds onto its components" do
    c = SmartAss::RGBAColor.new(50, 150, 200, 255)
    c.r.should == 50
    c.g.should == 150
    c.b.should == 200
    c.a.should == 255
    c.components.should == [50, 150, 200, 255]
  end

  it "can be created from a hex rgba" do
    c = SmartAss::RGBAColor.from_rgba(0xff, 0xff, 0xff, 0x00)
    c.components.should == [255, 255, 255, 0]
  end

  it "can be created from a hex argb" do
    c = SmartAss::RGBAColor.from_argb(0x00, 0xff, 0xff, 0xff)
    c.components.should == [255, 255, 255, 0]
  end

  it "can be created from an .ass hex" do
    c = SmartAss::RGBAColor.from_ass("&H00FFFFFF")
    c.components.should == [255, 255, 255, 0]
  end

end
