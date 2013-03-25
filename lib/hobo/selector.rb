# encoding: utf-8
# require 'option'

class Hobo::Selector
  attr_reader :name, :options

  def initialize(name, &block)
    @name = name
    @options = []

    instance_eval &block
  end

  def option(name)
    @options << Hobo::Option.new(name)
  end
end