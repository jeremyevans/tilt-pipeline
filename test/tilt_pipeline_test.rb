if ENV.delete('COVERAGE')
  require 'simplecov'

  SimpleCov.start do
    enable_coverage :branch
    add_filter "/test/"
    add_group('Missing'){|src| src.covered_percent < 100}
    add_group('Covered'){|src| src.covered_percent == 100}
  end
end

ENV['MT_NO_PLUGINS'] = '1' # Work around stupid autoloading of plugins
require 'minitest/autorun'
require 'tilt'
require 'tilt/string'
require 'tilt/erb'
require_relative '../lib/tilt/pipeline'

describe "tilt-pipeline without options" do
  before do
    @mapping = Tilt.default_mapping.dup
    @pipeline_class = @mapping.pipeline('str.erb')
  end

  it "returns a template class" do
    assert_equal Tilt::Pipeline, @pipeline_class.superclass
  end

  it "registers itself for the given extension" do
    assert_equal @pipeline_class, @mapping['it.str.erb']
  end

  it "renders templates starting with final extension to inner extensions" do
    template = @pipeline_class.new { |t| '#<%= \'{a = 1}\' %><%= \'#{a}\' %>' }
    assert_equal "11", template.render
  end

  it "can be rendered more than once" do
    template = @pipeline_class.new { |t| '<%= \'#{1}\' %>' }
    3.times { assert_equal "1", template.render }
  end

  it "passing locals" do
    template = @pipeline_class.new { |t| '<%= \'#{a}\' * a %>' }
    assert_equal "333", template.render(Object.new, :a => 3)
  end

  it "evaluating in an object scope" do
    template = @pipeline_class.new { |t| '<%= \'#{a}\' * a %>' }
    o = Object.new
    def o.a; 3 end
    assert_equal "333", template.render(o)
  end

  it "passing a block for yield" do
    template = @pipeline_class.new { |t| '<%= \'#{yield}\' * yield %>' }
    assert_equal "333", template.render { 3 }
    assert_equal "22", template.render { 2 }
  end
end

describe "tilt-pipeline with options" do
  before do
    @mapping = Tilt.default_mapping.dup
  end

  it "supports :templates option for specifying templates to use in order" do
    pipeline = @mapping.pipeline('setrrb', :templates=>['erb', 'str'])
    template = pipeline.new { |t| '#<%= \'{a = 1}\' %><%= \'#{a}\' %>' }
    assert_equal "11", template.render
  end

  it "supports :extra_exts option for specifying additional extensions to register" do
    @mapping.pipeline('str.erb', :extra_exts=>['setrrb', 'asdfoa'])
    ['str.erb', 'setrrb', 'asdfoa'].each do |ext|
      template = @mapping[ext].new { |t| '#<%= \'{a = 1}\' %><%= \'#{a}\' %>' }
      assert_equal "11", template.render
    end
  end

  it "supports per template class options" do
    pipeline = @mapping.pipeline('str.erb', 'erb'=>{:outvar=>'@foo'})
    template = pipeline.new { |t| '#<% @foo << \'{a = 1}\' %><%= \'#{a}\' %>' }
    assert_equal "11", template.render
  end
end

describe "Tilt.pipeline" do
  before do
    @mapping = Tilt.default_mapping.dup
  end
  after do
    Tilt.instance_variable_set(:@mapping, @mapping)
  end

  it "should modify the default mapping" do
    assert_equal "11", Tilt.pipeline('str.erb').new { |t| '#<%= \'{a = 1}\' %><%= \'#{a}\' %>' }.render
  end
end
