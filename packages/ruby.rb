Rove.package :ruby do
  category 'Languages'

  select 'Ruby Manager' do
    option :rvm do
      title 'RVM'

      cookbook 'build-essential'
      cookbook 'rvm', :github => 'fnichol/chef-rvm', :ref => 'v0.9.0'
      recipe 'rvm::vagrant'
      recipe 'rvm::system'
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
          inject_rbenv_ruby(config, '1.9.3-p484')
        end
      end

      option :rbenv_200 do
        title '2.0.0'

        config do |config|
          inject_rbenv_ruby(config, '2.0.0-p353')
        end
      end

      option :rbenv_210 do
        title '2.1.0'

        config do |config|
          inject_rbenv_ruby(config, '2.1.0-preview2')
        end
      end

      %w[2.1.1 2.1.2 2.1.3 2.1.4 2.1.5].each do |version|
        option version do
          title version
          config do |config|
            inject_rbenv_ruby(config, version)
          end
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