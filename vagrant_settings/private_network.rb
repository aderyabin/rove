Rove.vagrant_setting :private_network do

  config do |ip|
    "config.vm.network \"private_network\", ip: \"#{ip}\""
  end

  input :ip do
    title 'Private Network IP'
    default '10.10.10.10'
    config do |value|
      {
        private_network: {
          config: {
            ip: value
          }
        }
      }
    end
  end
end
