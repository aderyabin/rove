Hospice.package :git do
  category 'Version controls'
  cookbook 'git'
  recipe 'git'

  input :prefix do
    default '/usr/local'
    config {|value| {git: {prefix: value}}}
  end
end
