require_relative 'nap/helper'
require_relative 'nap/http_server'
require_relative 'nap/listener'

require 'yaml'

config_file = File.dirname(__FILE__) + "/../config/queues.yml"
config = YAML::load_file(config_file)

# initialize all queues in the config file
puts "start reading config file"
config["queues"].each do |q|
    listen q[0],q[1]
end
puts ".END."
