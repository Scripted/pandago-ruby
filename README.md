# PandaGo Ruby

[![Gem Version][gem_version_badge]][rubygems]
[![Travis CI][travis_badge]][travis]
[![Coverage Status][coverage_badge]][coverage]
[![Code Climate][codeclimate_badge]][codeclimate]
[![License][license_badge]][license]

A lightweight Ruby wrapper for [PandaGo](https://github.com/Scripted/pandago).

## Installation

Add this line to your application's Gemfile:

```ruby
gem "pandago", "~> 1.0.0"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pandago

## Configuration

You must to have a [PandaGo](https://github.com/Scripted/pandago) server running.

``` ruby
PandaGo.configure do |config|
  config.url = "http://your-pandago-instance.herokuapp.com"
  config.timeout = 10 # default is 5 seconds
end
```

## Usage

Given the file `hello_world.html`, just pass it into `#convert` with the input
and output formats.

``` ruby
file = File.open("hello_world.html")
file.read
# => "<h1>Hello, World!</h1>\n<p>Here's looking at you.</p>\n"

io = PandaGo.convert(file, from: :html, to: :markdown)
io.read
# => "Hello, World!\n=============\n\nHere's looking at you.\n"
```

You can also convert strings by wrapping them in a `StringIO` object.

``` ruby
string = "<h1>So Long!</h1><p>And thanks for all the fish.</p>"
input_io = StringIO.new(string)

io = PandaGo.convert(input_io, from: :html, to: :markdown)
io.read
# => "So Long!\n========\n\nAnd thanks for all the fish.\n"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/scripted/pandago. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[gem_version_badge]: http://img.shields.io/gem/v/pandago.svg?style=flat
[rubygems]: http://rubygems.org/gems/pandago

[travis_badge]: http://img.shields.io/travis/Scripted/pandago-ruby.svg?style=flat
[travis]: https://travis-ci.org/Scripted/pandago-ruby

[coverage_badge]: https://img.shields.io/coveralls/Scripted/pandago-ruby.svg?style=flat
[coverage]: https://coveralls.io/r/Scripted/pandago-ruby

[codeclimate_badge]: https://img.shields.io/codeclimate/github/Scripted/pandago-ruby.svg?style=flat
[codeclimate]: https://codeclimate.com/github/Scripted/pandago-ruby

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg?style=flat
[license]: https://github.com/Scripted/pandago-ruby/blob/master/LICENSE.txt
