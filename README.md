# PostHaste

A proof-of-concept Ruby library that wraps the JSON endpoints provided for Washington Post articles and blog posts. Potentially suitable for building custom feeds of Washington Post content.

## Installation

Add this line to your application's Gemfile:

    gem 'post_haste'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install post_haste

## Usage

Post Haste currently can accept a URL of a Washington Post article or blog post, and converts that URL into a Ruby object with a number of methods that describe it, including its title, byline, published and updated datetimes, and more.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
