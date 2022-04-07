# frozen_string_literal: true

require 'sinatra/base'
require 'rate_limit_mock_server/counter'
require 'rate_limit_mock_server/rate_limit_error'

module RateLimitMockServer
  class Server < Sinatra::Base
    set :show_exceptions, false

    DEFAULT_RPS_LIMIT = 4

    error do |err|
      [500, "Something is bork: #{err.message}"]
    end

    error RateLimitError do |error|
      [429, "Current rate for #{request.path_info}: #{error.rate} (allowed #{error.limit})\n"]
    end

    put '/quit' do
      self.class.quit!
    end

    get '/limit_test' do
      raise RateLimitError.new(rate: 1, limit: 0)
    end

    get %r{/(\d+)?} do
      counter.increment!

      [200, "Current rate for #{request.path_info}: #{counter.current}\n"]
    end

    def rps_limit
      params['captures']&.first&.to_i || DEFAULT_RPS_LIMIT
    end

    def counter
      Counter.for(request.path_info, rps_limit)
    end

    def user_agent
      request.env['HTTP_USER_AGENT']
    end
  end
end
