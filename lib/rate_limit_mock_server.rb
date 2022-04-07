# frozen_string_literal: true

require 'rate_limit_mock_server/version'
require 'rate_limit_mock_server/server'

module RateLimitMockServer
  def self.start(port: nil)
    Server.set :port, port if port
    Server.run!
  end

  def self.quit!
    Server.quit!
  end
end
