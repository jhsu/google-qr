require 'string'

class GoogleQR
  attr_accessor :data,
                :size,
                :use_https,
                :encoding,
                :error_correction
  
  def initialize(opts={})
    options = {
      :data => "http://google.com", 
      :size => "100x100", 
      :use_https => true
    }.merge!(opts)

    options.each {|key,value| self.send("#{key}=", value) }
  end

  def to_s
    if self.data
      params = ["chl=#{self.data}"]
      params << "chs=#{self.size}" if self.size
      params << "choe=#{self.encoding}" if self.encoding
      params << "chld=#{self.error_correction}" if self.error_correction
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
  
  private
  def base_url
    "http#{self.use_https ? 's' : ''}://chart.googleapis.com/chart?cht=qr&"
  end
end
