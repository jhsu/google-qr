require 'string'
require 'uri'

class GoogleQR
  attr_accessor :data,
                :size,
                :use_https,
                :encoding,
                :error_correction,
                :margin

  def initialize(opts={})
    options = {
      :size => "100x100",
      :use_https => true
    }.merge!(opts)

    options.each {|key,value| self.send("#{key}=", value) }
  end

  def to_s
    if self.data
      params = ["chl=#{URI.encode(self.data, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}"]
      params << "chs=#{self.size}"
      params << "choe=#{self.encoding}" if self.encoding
      params << error_correction_params if error_correction_param?
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
  
  def error_correction_param?
    self.error_correction || self.margin
  end
  
  def error_correction_params
    if !self.error_correction && self.margin
      param = "L|#{self.margin}"
    elsif self.error_correction && !self.margin
      param = self.error_correction
    else
      param = "#{self.error_correction}|#{self.margin}"
    end  
    
    "chld=#{param}"
  end
  
end