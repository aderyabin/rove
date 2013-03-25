# encoding: utf-8

class Hobo::Option
  attr_reader :name, :config

  def initialize(name, config = nil)
    @name = name
    @config = config
  end
end