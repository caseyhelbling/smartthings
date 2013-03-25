
require 'multi_json'
require 'faraday'
#require 'faraday_middleware'
#require 'hashie/mash'

require_relative 'smart_things/api'
require_relative 'smart_things/account'
require_relative 'smart_things/client'
require_relative 'smart_things/event'
require_relative 'smart_things/location'
require_relative 'smart_things/request'
require_relative 'smart_things/version'

require 'logger'

module SmartThings

  HOST = "graph.api.smartthings.com"

  DEFAULT_MIDDLEWARE = Proc.new do |faraday|

    faraday.adapter :net_http
    faraday.response :logger

    faraday.request :basic_auth, ENV['ST_USER_NAME'], ENV['ST_PASSWORD']
  end

  def self.logger
    @logger ||= Logger.new(STDOUT)
  end

end




