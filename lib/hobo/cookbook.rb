module Hobo
  class Cookbook
    attr_reader :name, :opts

    def initialize(name, opts ={})
      @name = name
      @opts = opts
    end
  end
end