Pod::Spec.new do |s|
  s.name             = "MARKTempoMeter"
  s.version          = "0.1.0"
  s.summary          = "A simple tool to measure the BPM (beats per minute)"
  s.homepage         = "https://github.com/markvaldy/MARKTempoMeter"
  s.license          = {
    :type => 'MIT',
    :file => 'LICENSE.md'
  }
  s.author           = { "Vadym Markov" => "impressionwave@gmail.com" }
  s.social_media_url = 'https://twitter.com/markvaldy'
  s.source           = {
    :git => "https://github.com/markvaldy/MARKTempoMeter.git",
    :tag => s.version.to_s
  }

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.frameworks = 'Foundation'

  s.source_files = 'Source/**/*.{h,m}'
end
