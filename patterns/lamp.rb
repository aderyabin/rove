Rove.pattern :lamp do
  title 'LAMP'

  package :apache
  package :mysql
  package :php
  vagrant_setting :port_forward, {:guest_port => 80, :host_port => 8080} #prefer host ports > 1024
end