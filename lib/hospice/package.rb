module Hospice
  class Package < Option
    include Support::Storer

    attr_reader :category, :settings

    def initialize(name, category, &block)
      @settings = []
      super(nil, name, self, &block)
      Hospice::Category.new(@category ||= category || 'Other')

      store
    end

    def ensure_option!(parent, name, package, &block)
      option = Option.new(parent, name, package, &block)

      if @settings.map{|x| x.id}.include?(option.id)
        raise "Setting '#{option.id}' is taken within '#{@name}'!"
      end

      @settings << option
      option
    end

    def ensure_input!(parent, name, package, &block)
      input = Input.new(parent, name, package, &block)

      if @settings.map{|x| x.id}.include?(input.id)
        raise "Setting '#{input.id}' is taken within '#{@name}'!"
      end

      @settings << input
      input
    end
  end
end