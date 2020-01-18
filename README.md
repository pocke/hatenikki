# Hatenikki

Write diary every day with Hatena blog.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hatenikki'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hatenikki

## Usage

```
# Print the today's article to STDOUT
$ hatenikki load

# Save the today's article from STDIN
$ hatenikki save

# Publish draft articles except today's one
$ hatenikki publish
```

* For more information (in Japanese): https://pocke.hatenablog.com/entry/2020/01/18/191652
* Related project: https://github.com/pocke/hatenikki.vim

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pocke/hatenikki.

