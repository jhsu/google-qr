require 'string'
require 'uri'

class GoogleQR
  attr_accessor :data, :size, :use_https, :encoding, :error_correction, :margin, :html_options

  def initialize(opts={})
    options = {
      :size => "100x100",
      :use_https => true
    }.merge!(opts)

    options.each {|key,value| self.send("#{key}=", value) }
  end

  def to_s
    if self.data
      params = ["chl=#{escape_string(self.data)}"]
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

    if self.html_options
      html_options = ""

      self.html_options.each do |k, v|
        if k.to_s.length > 0 && v.to_s.length > 0
          html_options += k.to_s + "='" + v.to_s + "' "
        end
      end
    else
      html_options = nil
    end

    "<img src='#{self.to_s}'#{dimensions}#{html_options}/>"
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
    
    "chld=#{escape_string(param)}"
  end
  
  def escape_string(string)
    URI.encode(string, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  end
  
end
