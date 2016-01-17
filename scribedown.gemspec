Gem::Specification.new do |s|
  s.name        = 'scribedown'
  s.version     = '0.0.1'
  s.date        = '2015-10-19'
  s.summary     = "Markdown into a PDF"
  s.description = "Markdown for report writing"
  s.authors     = ["Will Richardson"]
  s.email       = 'william.hamish@gmail.com'
  s.files       = Dir['lib/**/*.rb'] + Dir['bin/*'] + Dir['resources/**/*']
  s.executables = ['scribe']
  s.homepage    = 'http://javanut.net/scribedown'
  s.license     = 'MIT'
  s.add_runtime_dependency 'kramdown', '~> 1.8'
  s.add_runtime_dependency 'pdfkit', '~> 0.8'
end