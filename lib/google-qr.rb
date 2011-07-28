class GoogleQR
  attr_accessor :data, :size, :use_https
  def initialize(opts={:data => "http://google.com", :size => "100x100", :use_https => true})
    opts.each {|key,value| self.send("#{key}=", value) }
  end

  def to_s
    if self.data
      params = ["chl=#{self.data}"]
      params << "chs=#{self.size}" if self.size
      base_url + params.join("&")
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
  
  def base_url
    "http#{self.use_https ? 's' : ''}://chart.googleapis.com/chart?cht=qr&"
  end
end
