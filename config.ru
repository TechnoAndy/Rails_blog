# This file is used by Rack-based servers to start the application.
require 'thin'
require 'active_support/dependencies'
require 'action_controller'

require_relative 'config/environment'

run Rails.application
Rails.application.load_server
