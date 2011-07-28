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
      
      it "to_qr accepts the same args" do
        "ExampleQRData".to_qr(:size => "200x200").should == GoogleQR.new(:data => "ExampleQRData", :size => "200x200").to_s
      end
      
      it "to_qr_image accepts the same args" do
        "ExampleQRData".to_qr_image(:size => "200x200").should == 
          GoogleQR.new(:data => "ExampleQRData", :size => "200x200").render
      end
    end
  end
end