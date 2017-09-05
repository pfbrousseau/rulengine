# Rulengine

## Why

MIT license. Work problem

"Facts" change every time, rules don't. No need to optimize facts

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rulengine'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rulengine

Until it is moved to a generator, you will need to call this to setup the DB:
```
Rulengine::Engine.build_db
```

## Usage example

```
require 'rulengine'
Rulengine::Rule.connection

add_b = Rulengine::Rule.new given: ['a'], action: {'add': ['b']}
add_b.save!
remove_b = Rulengine::Rule.new given: ['a'], action: {'remove': ['b']}
remove_b.save!

Rulengine::Rule.find_conflicts
```

## Development

TODO: Move specs over

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rulengine.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
