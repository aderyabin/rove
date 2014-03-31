require_relative 'rove/support/storer'
require_relative 'rove/builder'
require_relative 'rove/category'
require_relative 'rove/cookbook'
require_relative 'rove/option'
require_relative 'rove/input'
require_relative 'rove/package'
require_relative 'rove/pattern'
require_relative 'rove/selector'
require_relative 'rove/vagrant_setting'

module Rove
  class << self
    def package(id, &block)
      Package.new(id, &block)
    end

    def pattern(title, &block)
      Pattern.new(title, &block)
    end

    def vagrant_setting(id, &block)
      VagrantSetting.new(id, &block)
    end    

    def packages
      Package.all.sort_by{|x| x.title}
    end

    def categories
      Category.all.sort_by{|x| x.title}
    end

    def patterns
      Pattern.all.sort_by{|x| x.title}
    end

    def vagrant_settings
      VagrantSetting.all.sort_by{|x| x.title}
    end    

    def load!(path)
      Dir["#{path.to_s}/*.rb"].each{|f| require f}
    end

    def [](id)
      Package[id]
    end
  end
end