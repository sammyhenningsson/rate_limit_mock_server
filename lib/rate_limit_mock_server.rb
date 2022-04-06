# frozen_string_literal: true

require 'rate_limit_mock_server/server'

module RateLimitMockServer
  def self.start
    Server.run!
  end
  
  def self.quit!
    Server.quit!
  end
end
