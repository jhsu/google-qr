class String
  def to_qr
    GoogleQR.new(:data => self).to_s
  end
  
  def to_qr_image
    GoogleQR.new(:data => self).render
  end
end