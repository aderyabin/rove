module Hospice
  class Option
    attr_reader :name, :config, :cookbooks, :recipes, :options, :config, :selectors

    def initialize(name, &block)
      @name      = name
      @config    = config
      @cookbooks = []
      @recipes   = []
      @options   = []
      @selectors = []

      instance_eval(&block)
    end


    def title(name = nil)
      @title ||= name || @name.to_s.capitalize
    end

    def cookbook(name, opts={})
      @cookbooks << Cookbook.new(name, opts)
    end

    def recipe(name)
      @recipes << name
    end

    def option(name, &block)
      @options << Option.new(name, &block)
    end

    def config(&block)
      @config = block.call if block_given?
    end

    def select(name, &block)
      @selectors << Selector.new(name, &block)
    end
  end
end