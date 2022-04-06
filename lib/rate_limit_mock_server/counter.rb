# frozen_string_literal: true

require 'rate_limit_mock_server/rate_limit_error'

module RateLimitMockServer
  class Counter
    class << self
      def for(key, rps_limit)
        counters[key] ||= Counter.new(rps_limit)
        counters[key]
      end

      private

      def counters
        @counters ||= {}
      end
    end

    def initialize(rps_limit)
      @rps_limit = rps_limit
      @window = []
    end

    def current
      size
    end

    def increment
      window << Time.now.to_f
      window.shift while delta && 1.0 < delta
      window.last
    end

    def increment!
      increment
      return if current <= rps_limit

      raise RateLimitError.new(rate: current, limit: rps_limit)
    end

    private

    def size
      window.size
    end

    def delta
      return if size < 2

      window.last - window.first
    end

    attr_reader :rps_limit, :window
  end
end
