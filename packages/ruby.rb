Hospice.package :ruby do
  category 'Languages'

  select 'Ruby Manager' do
    option :rvm do
      title 'RVM'

      cookbook 'rvm', :github => 'fnichol/chef-rvm', :ref => 'v0.9.0'
      recipe 'rvm'
    end

    option :rbenv do
      title 'rbenv'

      cookbook 'ruby_build', :github => 'fnichol/chef-ruby_build', :ref => 'v0.7.2'
      cookbook 'rbenv', :github => 'fnichol/chef-rbenv'
      recipe 'ruby_build'
      recipe 'rbenv::user'

      option :rbenv_193 do
        title '1.9.3'

        config do |config|
          inject_rbenv_ruby(config, '1.9.3-p392')
        end
      end

      option :rbenv_200 do
        title '2.0.0'

        config do |config|
          inject_rbenv_ruby(config, '2.0.0-p0')
        end
      end
    end
  end

  def inject_rbenv_ruby(config, ruby)
    config[:rbenv][:user_installs][0][:rubies] += [ruby]
    {}
  rescue
    {
      rbenv: {
        user_installs: [
          {
            user:   'vagrant',
            rubies: [ruby],
            global: ruby
          }
        ]
      }
    }
  end
end