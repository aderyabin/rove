Rove.pattern :rails do
  title 'Rails'

  package 'ruby', 'rbenv', 'rbenv_193', 'rbenv_200'
  package :postgresql
  package :redis
  package :git
  vagrant_setting :port_forward, {:guest_port => 3000, :host_port => 3000}
end