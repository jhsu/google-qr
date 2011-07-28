require File.dirname(__FILE__) + '/spec_helper'

describe "GoogleQR" do
  before do
    @qr_code = GoogleQR.new
  end
  
  it "knows the base google api url" do
    GoogleQR::BASE_URL.should == "https://chart.googleapis.com/chart?cht=qr&"
  end
  
  context "generating" do
    describe "to_s" do
      it "raises without data" do
        @qr_code.to_s.should raise_error
      end
    
      it "renders without size" do
        @qr_code.data = "ExampleQRData"
        @qr_code.to_s.should == "https://chart.googleapis.com/chart?cht=qr&chl=ExampleQRData"
      end
    
      it "render with a size given" do
        @qr_code.size = "100x100"
        @qr_code.to_s.should == "https://chart.googleapis.com/chart?cht=qr&chl=#{@qr_code.data}&chs=100x100"
      end
    end
  
    describe "render" do
      it "returns an <img /> tag" do
        @qr_code.size = nil
        @qr_code.render.should == "<img src='https://chart.googleapis.com/chart?cht=qr&chl=#{@qr_code.data}'/>"
      end
    
      it "returns and <img /> tag with width and height attributes" do
        @qr_code.size = "100x100"
        @qr_code.render.should == "<img src='https://chart.googleapis.com/chart?cht=qr&chl=#{@qr_code.data}&chs=#{@qr_code.size}' height='100' width='100' />"
      end
    end
  end
  
end