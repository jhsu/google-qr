class GoogleQR
  BASE_URL = "https://chart.googleapis.com/chart?cht=qr&"
  attr_accessor :data, :size
  def initialize(opts={:data => "http://google.com"})
    opts.each {|key,value| self.send("#{key}=", value) }
  end

  def to_s
    if self.data
      params = ["chl=#{self.data}"]
      params << "chs=#{self.size}" if self.size
      BASE_URL + params.join("&")
    else
      raise "Attribute @data is required for GoogleQR code"
    end
  end

  def render
    if self.size
      height, width = self.size.split('x')
      dimensions = " height='#{height}' width='#{width}' "
    else
      dimensions = nil
    end
    "<img src='#{self.to_s}'#{dimensions}/>"
  end
end
