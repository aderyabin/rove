Hospice.package :apache do
  category 'Web-Servers'
  cookbook 'apache2'
  recipe 'apache2'

  input :dir do
    default '/etc/apache2'
    config {|value| {apache: {dir: value}}}
  end

  input :log_dir do
    default '/var/log/apache2'
    config {|value| {apache: {log_dir: value}}}
  end

  input :error_log do
    default 'error.log'
    config {|value| {apache: {error_log: value}}}
  end

  input :user do
    default 'www-data'
    config {|value| {apache: {user: value}}}
  end

  input :group do
    default 'www-data'
    config {|value| {apache: {group: value}}}
  end

  input :binary do
    default '/usr/sbin/apache2'
    config {|value| {apache: {binary: value}}}
  end

  input :cache_dir do
    default '/var/cache/apache2'
    config {|value| {apache: {cache_dir: value}}}
  end

  input :pid_file do
    default '/var/run/apache2.pid'
    config {|value| {apache: {pid_file: value}}}
  end

  input :lib_dir do
    default '/usr/lib/apache2'
    config {|value| {apache: {lib_dir: value}}}
  end

  input :listen_ports do
    default '80'
    config {|value| {apache: {listen_ports: [value]}}}
  end

  input :contact do
    default 'ops@example.com'
    config {|value| {apache: {contact: value}}}
  end

  input :timeout do
    default '300'
    config {|value| {apache: {timeout: value}}}
  end

  input :keepalive do
    title 'Keep-Alive'
    default 'On'
    config {|value| {apache: {keepalive: value}}}
  end

  input :keepaliverequests do
    title 'Keep-Alive Requests'
    default '100'
    config {|value| {apache: {keepaliverequests: value}}}
  end

  input :keepalivetimeout do
    title 'Keep-Alive Timeout'
    default '5'
    config {|value| {apache: {keepalivetimeout: value}}}
  end
end