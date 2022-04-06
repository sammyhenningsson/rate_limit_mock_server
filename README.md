# RateLimitMockServer

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/rate_limit_mock_server`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

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
To start the server from code, do this:
```ruby
  require 'rate_limit_mock_server`

  # Start the server on port 4567 and block the current thread
  RateLimitMockServer.start
```

Note, If you don't want the server to block the current thread, you can instead spawn a new thread for the server.
```ruby
  require 'rate_limit_mock_server`

  thread = Thread.new do
    # Start the server on port 4567 and block the current thread
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

The server can be stopped by either `RateLimitMockServer.quit!` or by sending a GET to `http://localhost:4567/quit`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sammyhenningsson/rate_limit_mock_server.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
