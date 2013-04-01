Hospice.package :ruby do
  title 'Ruby'
  category 'Languages'

  select 'Ruby Manager' do
    option 'rvm' do
      cookbook 'rbenv', :github => 'fnichol/chef-rbenv'
      cookbook 'ruby_build', :github => 'fnichol/chef-ruby_build', :ref => 'v0.7.2'
      recipe 'rbenv::user'
      recipe 'ruby_build'
    end

    option 'rbenv' do
      cookbook 'rbenv', :github => 'fnichol/chef-rbenv'
      cookbook 'ruby_build', :github => 'fnichol/chef-ruby_build', :ref => 'v0.7.2'
      recipe 'rbenv::user'
      recipe 'ruby_build'

      option '1.9.3' do
        config do
          {
            :rbenv => {
              :user_installs => [
                {
                  :user => 'vagrant',
                  :rubies => ['1.8.7']
                }
              ]
            }
          }
        end
      end
    end
  end
end