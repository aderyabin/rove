Hospice.package :mysql do
  title 'MySQL'
  category 'Databases'

  cookbook 'mysql'
  recipe 'mysql::server'
  config do |config|
    config["mysql"] = {
      "server_root_password" => "password",
      "server_repl_password" => "password",
      "server_debian_password" => "password"
    }
  end
end
