module Rove
  class Package < Option
    include Support::Storer

    attr_reader :settings

    class << self
      def [](id)
        id = id.to_sym; Package.all.select{|x| x.id == id}.first
      end
    end

    def [](id)
      id = id.to_sym; @settings.select{|x| x.id == id}.first
    end

    def initialize(id, &block)
      @settings = []
      super(nil, id, self, &block)
      raise "You should set category for #{@id} package" if @category.blank?
      store
    end

    def category(title=false)
      return @category unless title
      @category = Rove::Category.build(title)
    end

    def finalizer(&block)
      @finalizer = block
    end

    def finalize(config)
      return config unless @finalizer
      @finalizer.call(config)
    end

    def configure(config, build)
      return {} unless @config

      result = case @config.arity
      when 0
        @config.call
      when 1
        @config.call config
      when 2
        @config.call config, build
      end

      result = {} unless result.is_a?(Hash)
      result
    end

    def ensure_option!(parent, id, package, &block)
      ensure! Option.new(parent, id, package, &block)
    end

    def ensure_input!(parent, id, package, &block)
      ensure! Input.new(parent, id, package, &block)
    end

    def ensure!(entity)
      if @settings.map{|x| x.id}.include?(entity.id)
        raise "Setting '#{entity.id}' is taken within '#{@id}'!"
      end

      @settings << entity
      entity
    end
  end
end