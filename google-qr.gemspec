Gem::Specification.new do |s|
  s.name          = "google-qr"
  s.version       = "0.2.2"
  s.date          = "2012-05-11"
  s.platform      = Gem::Platform::RUBY
  s.summary       = "Wrapper for Google Chart QR code"
  s.description   = "Generate URL string for Google QR code and render HTML img string"

  s.authors  = ["Joseph Hsu", "Nick Hammond"]
  s.license = 'MIT'
  s.email    = ["jhsu@josephhsu.com", "nick@nickhammond.com"]
  s.homepage = "http://github.com/jhsu/google-qr"

  s.require_paths = ["lib"]
  s.files = Dir["README", "lib/*"]

  s.required_ruby_version     = '>= 1.8.7'
  s.required_rubygems_version = ">= 1.3.6"
end
