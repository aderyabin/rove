# encoding: utf-8
class Hobo::Package
  attr_reader :name, :builder, :options, :selectors, :recipes, :cookbooks

  @@instances  = []

  def self.all
    @@instances
  end

  def initialize(name, &block)
    @@instances << self
    @name = name
    @options = []
    @selectors = []
    @recipes = []
    @cookbooks = {}
    instance_eval &block
  end

  def title(name = nil)
    @title ||= name || @name.to_s.capitalize
  end

  def category(name = nil)
    @category ||= name || 'Other'
    Hobo::Category.new(@category)
    @category
  end

  def recipe(name)
    @recipes << name
  end

  def cookbook(name, options = {})
    @cookbooks.merge!({ name => options })
  end
end