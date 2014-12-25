Rove.vagrant_setting :vm_params do

  config do |cpus, memory|
    "config.vm.provider \"virtualbox\" do |vb|
       vb.memory = #{memory}
       vb.cpus = #{cpus}
    end"
  end

  input :cpus do
    title 'CPUs'
    default '1'
    config do |value|
      {
        vm_params: {
          config: {
            vm_params: value
          }
        }
      }
    end
  end

  input :memory do
    title 'Memory (MB)'
    default '1024'
    config do |value|
      {
        vm_settings: {
          config: {
            memory: value
          }
        }
      }
    end
  end

end
