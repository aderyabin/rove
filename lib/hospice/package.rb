module Hospice
  class Package < Option
    include Support::Storer

    attr_reader :category, :recursive_options

    def initialize(name, category, &block)
      @recursive_options = []
      super(nil, name, self, &block)
      Hospice::Category.new(@category ||= category || 'Other')

      store
    end

    def ensure_option!(parent, name, package, &block)
      option = Option.new(parent, name, package, &block)

      if @options.map{|x| x.id}.include?(option.id)
        raise "Option '#{option.id}' is taken within '#{@name}'!"
      end

      @recursive_options << option
      option
    end
  end
end