require_relative 'lib/hospice'

Hospice.load! "#{File.dirname(__FILE__)}/packages"
Hospice.load! "#{File.dirname(__FILE__)}/patterns"