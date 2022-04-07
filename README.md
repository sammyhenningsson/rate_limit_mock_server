# RateLimitMockServer

A mock server for testing rate limits.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rate_limit_mock_server'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rate_limit_mock_server

## Usage
Run the server in a shell:
```sh
# On default port: 4567
$ rate_limit_mock_server

# Or specify the port with
$ rate_limit_mock_server --port= 3000
# Or 
$ rate_limit_mock_server -p 3000
```

To start the server from code, do this:
```ruby
  require 'rate_limit_mock_server`

  # Start the server on the default port 4567 and block the current thread
  RateLimitMockServer.start

  # Or start the server on the specified port and block the current thread
  RateLimitMockServer.start(port: 1337)
```

Note, If you don't want the server to block the current thread, you can instead spawn a new thread for the server.
```ruby
  require 'rate_limit_mock_server`

  thread = Thread.new do
    # Start the server on port 4567
    RateLimitMockServer.start
  end

  # Add some sleep to allow the server to be started
  sleep(2)
  
  do_some
  other_stuff
  # ...

  RateLimitMockServer.quit!
  thread.join
```

The server responds to the following routes:
 - `GET /limit_test` - Returns a "429 Too Many Requests" response (only for showing how such a response look).
 - `PUT /quit` - Stops the server.
 - `GET /:rate_limit` - Rate limited resources where `:rate_limit` is an integer that specifies the rate limit.

The "main" route (`GET /:rate_limit`) can be used to test different rate limits simultaneously. E.g. requests to
`GET /5` will be limited at 5 rps, while requests to `GET /20` will be limited at 20 rps.

Note: `:rate_limit` must be an integer greater than or equal to `1`. I.e it's not possible to user rate limits lower than 1 rps.

The server can be stopped by either `RateLimitMockServer.quit!` or by sending a PUT request to `http://localhost:4567/quit`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sammyhenningsson/rate_limit_mock_server.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
