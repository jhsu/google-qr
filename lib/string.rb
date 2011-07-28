class String
  def to_qr(opts={})
    opts[:data] = self
    GoogleQR.new(opts).to_s
  end
  
  def to_qr_image(opts={})
    opts[:data] = self
    GoogleQR.new(opts).render
  end
end