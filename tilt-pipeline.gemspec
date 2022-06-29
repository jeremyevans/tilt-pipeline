spec = Gem::Specification.new do |s|
  s.name = 'tilt-pipeline'
  s.version = '1.0.0'
  s.platform = Gem::Platform::RUBY
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG", "MIT-LICENSE"]
  s.rdoc_options += ["--quiet", "--line-numbers", "--inline-source", '--title', 'tilt-pipeline: Easily construct rendering pipelines using tilt', '--main', 'README.rdoc']
  s.license = "MIT"
  s.summary = "Easily construct rendering pipelines using tilt"
  s.author = "Jeremy Evans"
  s.email = "code@jeremyevans.net"
  s.homepage = "https://github.com/jeremyevans/tilt-pipeline"
  s.files = %w(MIT-LICENSE CHANGELOG README.rdoc Rakefile) + Dir["{test,lib}/**/*.rb"]
  s.description = <<END
tilt-pipeline allows you to easily construct rendering pipelines using tilt.
For example, you can register the scss.erb pipeline so that your scss
templates will be preprocessed by ERB before being processed by sass.
END
  s.required_ruby_version = ">= 1.9.2"
  s.add_dependency('tilt', '>= 2')
  s.add_development_dependency('minitest')
end
