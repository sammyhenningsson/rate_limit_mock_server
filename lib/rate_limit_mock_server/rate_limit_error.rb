# frozen_string_literal: true

module RateLimitMockServer
  class RateLimitError < StandardError
    MESSAGE_TEMPLATE = 'Received requests @%0.1f rps! Max allowed: %d rps'

    attr_reader :rate, :limit

    def initialize(rate:, limit:)
      @rate = rate
      @limit = limit

      super format(MESSAGE_TEMPLATE, rate, limit)
    end
  end
end
