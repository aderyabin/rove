Hospice.package :nginx do
  category 'Web-Servers'
  cookbook 'nginx'
  recipe 'nginx'

  input :dir do
    default '/etc/nginx'
    config {|value| {nginx: {dir: value}}}
  end

  input :log_dir do
    default '/var/log/nginx'
    config {|value| {nginx: {log_dir: value}}}
  end

  input :binary do
    default '/usr/sbin/nginx'
    config {|value| {nginx: {binary: value}}}
  end

  input :user do
    default 'www-data'
    config {|value| {nginx: {user: value}}}
  end

  input :init_style do
    default 'runit'
    config {|value| {nginx: {init_style: value}}}
  end

  input :pid do
    default '/var/run/nginx.pid'
    config {|value| {nginx: {pid: value}}}
  end

  input :worker_connections do
    default '1024'
    config {|value| {nginx: {worker_connections: value}}}
  end
end