module Hospice
  class Input < Option
    def configure(value, config, build)
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