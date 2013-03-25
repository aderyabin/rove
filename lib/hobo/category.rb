# encoding: utf-8

class Hobo::Category

  attr_reader :name

  @@instances = []

  def initialize(name)
    @name = name
    @@instances << self unless @@instances.collect(&:name).include?(name)
  end

  def self.all
    @@instances
  end


  def packages
    Hobo::Package.all.select{ |p| p.category == name }
  end
end