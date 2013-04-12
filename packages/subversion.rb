Hospice.package :subversion do
  category 'Version controls'

  cookbook 'subversion'
  recipe 'subversion'

  input :repo_dir do
    default '/srv/svn'
    config {|value| {subversion: {repo_dir: value}}}
  end

  input :repo_name do
    default 'repo'
    config {|value| {subversion: {repo_name: value}}}
  end

  input :server_name do
    default 'svn'
    config {|value| {subversion: {server_name: value}}}
  end

  input :user do
    default 'subversion'
    config {|value| {subversion: {user: value}}}
  end

  input :password do
    default 'subversion'
    config {|value| {subversion: {password: value}}}
  end
end
