require File.dirname(__FILE__) + '/spec_helper'

describe "GoogleQR" do
  before do
    @qr_code = GoogleQR.new
  end

  context "generating" do
    describe "to_s" do
      it "raises without data" do
        @qr_code.data = nil
        lambda{@qr_code.to_s}.should raise_error
      end

      it "renders with url-encoded data" do
        @qr_code.data = "http://ExampleQRData"
        @qr_code.to_s.should == "https://chart.googleapis.com/chart?cht=qr&chl=#{URI.encode(@qr_code.data, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}&chs=100x100"
      end

      it "renders with the default size of 100x100" do
        @qr_code.data = "ExampleQRData"
        @qr_code.to_s.should == "https://chart.googleapis.com/chart?cht=qr&chl=ExampleQRData&chs=100x100"
      end

    end

    describe "renders" do
      it "renders and <img /> tag with width and height attributes" do
        @qr_code.size = "100x100"
        @qr_code.data = "https://www.google.com/images/logo.png"
        @qr_code.render.should == "<img src='https://chart.googleapis.com/chart?cht=qr&chl=#{URI.encode(@qr_code.data, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}&chs=#{@qr_code.size}' height='100' width='100' />"
      end

      it "renders and <img /> tag with html attributes given in html_options" do
        @qr_code.data = "https://www.google.com/images/logo.png"
        @qr_code.html_options = { :class => "img_class", :style => "margin-left:12px;" }
        @qr_code.render.should == "<img src='https://chart.googleapis.com/chart?cht=qr&chl=#{URI.encode(@qr_code.data, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}&chs=#{@qr_code.size}' height='100' width='100' class='img_class' style='margin-left:12px;' />"
      end
    end

    describe "options" do
      before do
        @qr_code.data = "SampleData"
      end
      
      it "can set encoding" do
        @qr_code.encoding = "Shift_JIS"
        @qr_code.to_s.should == "https://chart.googleapis.com/chart?cht=qr&chl=#{@qr_code.data}&chs=#{@qr_code.size}&choe=Shift_JIS"
      end

      it "can set error correction level" do
        @qr_code.error_correction = "L"
        @qr_code.to_s.should == "https://chart.googleapis.com/chart?cht=qr&chl=#{@qr_code.data}&chs=#{@qr_code.size}&chld=L"
      end
      
      it "can set error correction the google way" do
        @qr_code.error_correction = "L|5"
        @qr_code.to_s.should == "https://chart.googleapis.com/chart?cht=qr&chl=#{@qr_code.data}&chs=#{@qr_code.size}&chld=L%7C5"        
      end
      
      it "can set just margin" do
        @qr_code.margin = 1
        @qr_code.to_s.should == "https://chart.googleapis.com/chart?cht=qr&chl=#{@qr_code.data}&chs=#{@qr_code.size}&chld=L%7C1"
      end
      
      it "can set error correction & margin" do
        @qr_code.margin = 2
        @qr_code.error_correction = "M"
        @qr_code.to_s.should == "https://chart.googleapis.com/chart?cht=qr&chl=#{@qr_code.data}&chs=#{@qr_code.size}&chld=M%7C2"
      end
      
      it "renders with a size given" do
        @qr_code.size = "200x200"
        @qr_code.to_s.should == "https://chart.googleapis.com/chart?cht=qr&chl=#{@qr_code.data}&chs=200x200"
      end

      it "renders without https if requested" do
        @qr_code.use_https = false
        @qr_code.to_s.should == "http://chart.googleapis.com/chart?cht=qr&chl=#{@qr_code.data}&chs=#{@qr_code.size}"
      end
      
    end

  end

end
