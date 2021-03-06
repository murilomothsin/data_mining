#!/usr/bin/env ruby

require_relative 'config'

username = AppConfig::USERNAME
client_db = AppConfig::mongo_client

rank_following = client_db[:rank_following]

the_master = rank_following.find({ name: username })
following = the_master.first[:rank_following]

names = following.map { |f| [f[:name]] + f[:followers]}.flatten.uniq
resources_obj = names.map { |n| { name: n } }


resources = client_db[:resources]
the_master = resources.find({ name: username })

resources_obj.each do |r|
  resources.insert_one(r)
end



