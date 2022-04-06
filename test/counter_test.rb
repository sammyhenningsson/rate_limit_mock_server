require 'test_helper'

module RateLimitMockServer
  class TestCounter < Minitest::Test
    def setup
      @counter = Counter.new(5)
    end

    def test_increment
      assert @counter.increment
    end

    def test_current_when_no_request_have_been_made
      assert_equal 0, @counter.current
    end

    def test_current_when_more_than_1_s_is_between_requests
      @counter.increment
      sleep 1.1
      @counter.increment

      assert_equal 1, @counter.current
    end

    def test_current_when_multiple_request_has_been_made_within_1_s
      4.times do
        @counter.increment
        sleep 0.1
      end

      assert_equal 4, @counter.current
    end

    def test_raise_error_when_rate_is_too_high
      5.times do
        @counter.increment!
        sleep 0.1
      end

      assert_raises(RateLimitError) do
        @counter.increment!
      end
    end
  end
end
