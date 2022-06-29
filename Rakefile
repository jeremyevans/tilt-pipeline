require "rake/clean"

CLEAN.include ["tilt-pipeline-*.gem", "rdoc", "coverage"]

desc "Build tilt-pipeline gem"
task :package=>[:clean] do |p|
  sh %{#{FileUtils::RUBY} -S gem build tilt-pipeline.gemspec}
end

### Specs

desc "Run tests"
task :test do
  sh "#{FileUtils::RUBY} #{"-w" if RUBY_VERSION >= '3'} test/tilt_pipeline_test.rb"
end

task :default => :test

desc "Run tests with coverage"
task :test_cov do 
  ENV['COVERAGE'] = '1'
  sh "#{FileUtils::RUBY} test/tilt_pipeline_test.rb"
end

### RDoc

require "rdoc/task"

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.options += ["--quiet", "--line-numbers", "--inline-source", '--title', 'tilt-pipeline: Easily construct rendering pipelines using tilt', '--main', 'README.rdoc']

  begin
    gem 'hanna-nouveau'
    rdoc.options += ['-f', 'hanna']
  rescue Gem::LoadError
  end

  rdoc.rdoc_files.add %w"README.rdoc CHANGELOG MIT-LICENSE lib/**/*.rb"
end
