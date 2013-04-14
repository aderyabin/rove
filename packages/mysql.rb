Rove.package :mysql do
  title 'MySQL'
  category 'Databases'

  cookbook 'mysql'
  recipe 'mysql::server'

  input :password do
    title 'Superuser password'
    default 'password'

    config do |value|
      {
        mysql: {
          server_root_password: value,
          server_repl_password: value,
          server_debian_password: value
        }
      }
    end
  end

  input :service_name do
    default 'mysql'
    config {|value| {mysql: {service_name: value}}}
  end

  input :basedir do
    default '/usr'
    config {|value| {mysql: {basedir: value}}}
  end

  input :data_dir do
    default '/var/lib/mysql'
    config {|value| {mysql: {data_dir: value}}}
  end

  input :root_group do
    default 'root'
    config {|value| {mysql: {root_group: value}}}
  end

  input :mysqladmin_bin do
    title "Mysqladmin binary"
    default '/usr/bin/mysqladmin'
    config {|value| {mysql: {mysqladmin_bin: value}}}
  end

  input :mysql_bin do
    title "Mysql binary"
    default '/usr/bin/mysql'
    config {|value| {mysql: {mysql_bin: value}}}
  end

  input :conf_dir do
    default '/etc/mysql'
    config {|value| {mysql: {conf_dir: value}}}
  end

  input :confd_dir do
    default '/etc/mysql/conf.d'
    config {|value| {mysql: {confd_dir: value}}}
  end

  input :socket do
    title "Socket file"
    default '/var/run/mysqld/mysqld.sock'
    config {|value| {mysql: {socket: value}}}
  end

  input :pid_file do
    title "Pid file"
    default '/var/run/mysqld/mysqld.pid'
    config {|value| {mysql: {pid_file: value}}}
  end

  input :grants_path do
    default '/etc/mysql/grants.sql'
    config {|value| {mysql: {grants_path: value}}}
  end
end