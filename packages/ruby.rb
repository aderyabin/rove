Hospice.package 'Ruby' => 'Languages' do
  input 'test' do
    input 'test2'

    config do |value|
    end
  end

  select 'Ruby Manager' do
    option 'rvm' do
      cookbook 'rvm', :github => 'fnichol/chef-rvm', :ref => 'v0.9.0'
      recipe 'rvm'
    end

    option 'rbenv' do
      cookbook 'ruby_build', :github => 'fnichol/chef-ruby_build', :ref => 'v0.7.2'
      cookbook 'rbenv', :github => 'fnichol/chef-rbenv'
      recipe 'rbenv::user'
      recipe 'ruby_build'

      option '1.9.3' do
        config do
          {
            :rbenv => {
              :user_installs => [
                {
                  :user => 'vagrant',
                  :rubies => ['1.8.7-p371']
                }
              ]
            }
          }
        end
      end

      option '2.0.0' do
        config do
          {
            :rbenv => {
              :user_installs => [
                {
                  :user => 'vagrant',
                  :rubies => ['2.0.0p0']
                }
              ]
            }
          }
        end
      end
    end
  end
end