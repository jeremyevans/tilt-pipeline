require "rake"
require "rake/clean"

CLEAN.include ["tilt-pipeline-*.gem", "rdoc", "coverage"]

desc "Build tilt-pipeline gem"
task :package=>[:clean] do |p|
  sh %{#{FileUtils::RUBY} -S gem build tilt-pipeline.gemspec}
end

### Specs

desc "Run tests"
task :test do
  sh "#{FileUtils::RUBY} -rubygems test/tilt_pipeline_test.rb"
end

task :default => :test

### RDoc

RDOC_DEFAULT_OPTS = ["--quiet", "--line-numbers", "--inline-source", '--title', 'tilt-pipeline: Easily construct rendering pipelines using tilt']

begin
  gem 'hanna-nouveau'
  RDOC_DEFAULT_OPTS.concat(['-f', 'hanna'])
rescue Gem::LoadError
end

rdoc_task_class = begin
  require "rdoc/task"
  RDoc::Task
rescue LoadError
  require "rake/rdoctask"
  Rake::RDocTask
end

RDOC_OPTS = RDOC_DEFAULT_OPTS + ['--main', 'README.rdoc']

rdoc_task_class.new do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.options += RDOC_OPTS
  rdoc.rdoc_files.add %w"README.rdoc CHANGELOG MIT-LICENSE lib/**/*.rb"
end

