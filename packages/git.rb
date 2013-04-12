Hospice.package :git do
  category 'Version controls'
  cookbook 'git'
  recipe 'git'

  input :version do
    default '1.8.2.1'
    config {|value| {git: {version: value}}}
  end

  input :prefix do
    default '/usr/local'
    config {|value| {git: {prefix: value}}}
  end
end
