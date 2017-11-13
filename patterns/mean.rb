Rove.pattern :mean do
  title 'MEAN'

  package :mongo_db
  package :nodejs
  package :git
  vagrant_setting :port_forward, {:guest_port => 3000, :host_port => 3000} #prefer host ports > 1024
end
