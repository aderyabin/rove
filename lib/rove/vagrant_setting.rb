module Rove
  class VagrantSetting < Option
    include Support::Storer

    attr_reader :settings, :write_line

    class << self
      def [](id)
        id = id.to_sym; VagrantSetting.all.select{|x| x.id == id}.first
      end
    end

    def [](id)
      id = id.to_sym; @settings.select{|x| x.id == id}.first
    end

    def initialize(id, &block)
      @settings = []
      super(nil, id, self, &block)

      store
    end

    def category(title=false)
      return self.class.name
    end

    def write_line
      @output
    end

    def configure(values)
      @output = "" unless @config

      @output = @config.call *values if @config
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