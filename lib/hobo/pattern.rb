module Hobo
  class Pattern
    include Support::Storer

    attr_reader :name

    def initialize(name, &block)
      @name = name
      store
    end
  end
end