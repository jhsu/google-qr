require File.dirname(__FILE__) + '/spec_helper'

describe "GoogleQR" do
  describe "to_qr" do
    context "String objects" do
      it "returns a qr code image string" do
        "ExampleQRData".to_qr.should == GoogleQR.new(:data => "ExampleQRData").to_s
      end
    
      it "returns a qr code <img /> tag" do
        "ExampleQRData".to_qr_image.should == GoogleQR.new(:data => "ExampleQRData").render
      end
    end
  end
end