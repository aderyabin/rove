Rove.package :mongo_db do
  title 'MongoDB'
  category 'Databases'

  cookbook 'mongodb'
  recipe 'mongodb::default'

  input :dbpath do
    title 'DB path'
    default '/var/lib/mongodb'
    config {|value| {mongodb: {dbpath: value}}}
  end

  input :logpath do
    title 'Log path'
    default '/var/log/mongodb'
    config {|value| {mongodb: {logpath: value}}}
  end

  input :port do
    default '27017'
    config {|value| {mongodb: {port: value}}}
  end
end
