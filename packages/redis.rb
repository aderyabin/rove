Hospice.package :redis do
  title 'Redis'
  category 'Databases'

  cookbook 'redis', github: 'ctrabold/chef-redis'
  recipe 'redis'

  input :bind do
    default '127.0.0.1'
    config {|value| {redis: {bind: value}}}
  end

  input :port do
    default '6379'
    config {|value| {redis: {port: value}}}
  end

  input :config_path do
    default '/etc/redis/redis.conf'
    config {|value| {redis: {config_path: value}}}
  end

  input :daemonize do
    default 'yes'
    enum    'yes', 'no'

    config {|value| {redis: {daemonize: value}}}
  end

  input :timeout do
    default '300'
    config {|value| {redis: {timeout: value}}}
  end

  input :loglevel do
    default 'notice'
    enum    'notice', 'warning'

    config {|value| {redis: {loglevel: value}}}
  end

  input :password do
    config {|value| {redis: {password: value}}}
  end
end
