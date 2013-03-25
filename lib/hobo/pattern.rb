# encoding: utf-8

class Hobo::Pattern
  @@instances  = []

  def self.all
    @@instances
  end

  def initialize(name, &block)
    @@instances << self
  end
end