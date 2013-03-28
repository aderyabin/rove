# encoding: utf-8
module Hobo
  class Package < Option
    @@instances  = []

    def self.all
      @@instances
    end

    def initialize(name, &block)
      @@instances << self
      super
    end

    def category(name = nil)
      @category ||= name || 'Other'
      Hobo::Category.new(@category)
      @category
    end
  end
end