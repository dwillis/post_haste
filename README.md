# PostHaste

A proof-of-concept Ruby library that wraps the JSON endpoints provided for Washington Post articles and blog posts. Potentially suitable for building custom feeds of Washington Post content, in the event that you don't want to actually visit washingtonpost.com.

Tested under Ruby 1.9.2, but other versions should work.

## Installation

Add this line to your application's Gemfile:

    gem 'post_haste'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install post_haste

## Usage

Post Haste currently can accept a URL of a Washington Post article or blog post, and converts that URL into a Ruby object with a number of methods that describe it, including its title, byline, published and updated datetimes, and more:

  url = "http://www.washingtonpost.com/blogs/the-fix/post/republicans-on-the-2012-gop-field-blah/2012/03/15/gIQAT7CSFS_blog.html"
  @article = Article.create_from_url(url)
  => #<PostHaste::Article:0x000001009f3228 @type="BlogStory", @uuid="ce8a183a-6f0c-11e1-9118-82b72e1e284a", @title="Republicans on the 2012 GOP field: Blah.", @blurb=nil, @has_correction=false, @correction=nil, @has_clarification=false, @clarification=nil, @permalink="http://www.washingtonpost.com/blogs/the-fix/post/republicans-on-the-2012-gop-field-blah/2012/03/15/gIQAT7CSFS_blog.html", @short_url="http://wapo.st/zeg0JO", @byline="Chris Cillizza and Aaron Blake",....>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
