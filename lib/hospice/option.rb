module Hospice
  class Option
    attr_reader :id, :package, :name, :cookbooks, :recipes, :options, :selectors

    def initialize(parent, name, package, &block)
      @id        = [parent.try(:id), name.underscore].compact.join('-')
      @name      = name
      @package   = package
      @cookbooks = []
      @recipes   = []
      @options   = []
      @selectors = []

      instance_eval &block if block_given?
    end

    def cookbook(name, opts={})
      @cookbooks << Cookbook.new(name, opts)
    end

    def recipe(name)
      @recipes << name
    end

    def option(name, &block)
      @options << package.ensure_option!(self, name, package, &block)
    end

    def config(&block)
      @config = block.call if block_given?
      @config
    end

    def select(name, &block)
      @selectors << Selector.new(self, name, package, &block)
    end
  end
end