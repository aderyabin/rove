# encoding: utf-8

module Hobo
  class Pattern
    @@instances  = []

    def self.all
      @@instances
    end

    def initialize(name, &block)
      @@instances << self
    end
  end
end