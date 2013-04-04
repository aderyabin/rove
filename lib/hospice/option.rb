module Hospice
  class Option
    attr_reader :id, :package, :cookbooks, :recipes, :options, :inputs, :selectors

    def initialize(parent, id, package, &block)
      @id         = id.to_sym
      @title      = id.to_s.humanize
      @package    = package
      @cookbooks  = []
      @recipes    = []
      @options    = []
      @inputs     = []
      @selectors  = []

      instance_eval &block if block_given?
    end

    def title(title=false)
      return @title unless title
      @title = title
    end

    def cookbook(name, opts={})
      @cookbooks << Cookbook.new(name, opts)
    end

    def recipe(name)
      @recipes << name
    end

    def option(id, &block)
      @options << package.ensure_option!(self, id, package, &block)
    end

    def input(id, &block)
      @inputs << package.ensure_input!(self, id, package, &block)
    end

    def config(&block)
      @config = block
    end

    def configure(value, build, config)
      return {} unless @config

      result = case @config.arity
      when 0
        package.instance_eval &@config
      when 1
        package.instance_exec value, &@config
      when 2
        package.instance_exec value, build, &@config
      when 3
        package.instance_exec value, build, config, &@config
      end

      result = {} unless result.is_a?(Hash)
      result
    end

    def select(title, &block)
      @selectors << Selector.new(self, title, package, &block)
    end
  end
end