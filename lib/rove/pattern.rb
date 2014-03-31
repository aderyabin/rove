module Rove
  class Pattern
    include Support::Storer

    attr_reader :id, :packages, :build, :vagrant_settings

    class << self
      def [](id)
        id = id.to_sym; Pattern.all.select{|x| x.id == id}.first
      end
    end

    def initialize(id, &block)
      @id       = id.to_sym
      @title    = id.to_s.humanize
      @packages = {}
      @vagrant_settings = {}

      instance_eval &block if block_given?
      store
    end

    def title(title=false)
      return @title unless title
      @title = title
    end

    def package(id, *options)
      options = options[0] if options[0].is_a?(Hash)

      if options.is_a?(Array)
        options = Hash[*options.map{|x| [x,nil]}.flatten]
      end

      @packages[id] = options
    end

    def build

      config = @packages.merge @vagrant_settings

      config.with_indifferent_access

    end

    def vagrant_setting(id, *options)

      options = options[0] if options[0].is_a?(Hash)

      if options.is_a?(Array)
        options = Hash[*options.map{|x| [x,nil]}.flatten]
      end

      @vagrant_settings[id] = options
      
    end
  end
end