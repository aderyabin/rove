require_relative 'lib/rove'

Rove.load! "#{File.dirname(__FILE__)}/packages"
Rove.load! "#{File.dirname(__FILE__)}/patterns"
Rove.load! "#{File.dirname(__FILE__)}/vagrant_settings"