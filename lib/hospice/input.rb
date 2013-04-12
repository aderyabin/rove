module Hospice
  class Input < Option
    def default(value=false)
      return @default unless value
      @default = value
    end

    def enum(*args)
      return @enum if args.length == 0
      @enum = if args.length > 1
        args
      else
        args.first.to_a
      end
    end

    def configure(value, config, build)
      value = default if value.blank?
      return {} unless @config

      result = case @config.arity
      when 0
        package.instance_eval &@config
      when 1
        package.instance_exec value, &@config
      when 2
        package.instance_exec value, config, &@config
      when 3
        package.instance_exec value, config, build, &@config
      end

      result = {} unless result.is_a?(Hash)
      result
    end
  end
end