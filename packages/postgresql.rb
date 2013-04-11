Hospice.package :postgresql do
  title 'PostgreSQL'
  category 'Databases'

  cookbook 'postgresql'
  recipe 'postgresql::server'

  config do |config|
    config["postgresql"] = {
      :config => {
        :listen_addresses => '*'
      },
      "password" => {
        "postgres" => "password"
      },
      :pg_hba => [
        {:type => 'local', :db => 'postgres', :user => 'postgres', :addr => nil, :method => 'trust'},
        {:type => 'host', :db => 'all', :user => 'all', :addr => '0.0.0.0/0', :method => 'md5'},
        {:type => 'host', :db => 'all', :user => 'all', :addr => '::1/0', :method => 'md5'}
      ]
    }
  end
end
