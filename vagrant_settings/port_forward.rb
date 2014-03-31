Rove.vagrant_setting :port_forward do

  config do |guest_port, host_port|
    "config.vm.network :forwarded_port, guest: #{guest_port}, host: #{host_port}"
  end

  input :guest_port do
    title 'Guest port'
    default '3000'
    config do |value|
      {
        port_forward: {
          config: {
            guest_port: value
          }
        }
      }
    end
  end

  input :host_port do
    title 'Host port'
    default '3000'
    config do |value|
      {
        port_forward: {
          config: {
            host_port: value
          }
        }
      }
    end
  end

end
