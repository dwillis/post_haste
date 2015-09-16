# PostHaste

A Ruby library that wraps the JSON endpoints provided for Washington Post articles and blog posts. Potentially suitable for building custom feeds of Washington Post content, in the event that you don't want to actually visit washingtonpost.com. It handles articles and blog posts from the Post's CMS (along with the most recent 15 comments), as well as The Post's WordPress-powered blogs. Post Haste also provides a wrapper to "Most Viewed" articles and blog posts.

Tested under Ruby 1.9.3, 2.0.0, 2.1.0 and 2.2.x.

## Installation

Add this line to your application's Gemfile:

    gem 'post_haste'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install post_haste

## Usage

Post Haste currently can accept a URL of a Washington Post article or blog post, and converts that URL into a Ruby object with a number of methods that describe it, including its title, byline, published and updated datetimes, and more:

```ruby
  require 'post_haste'
  include PostHaste

  url = "http://www.washingtonpost.com/blogs/the-fix/post/republicans-on-the-2012-gop-field-blah/2012/03/15/gIQAT7CSFS_blog.html"

  @article = Article.create_from_url(url, 10) # 10 represents number of comments to grab, default is 25.

  @article.title

  => "Republicans on the 2012 GOP field: Blah."

  @article.display_datetime.to_s

  => "2012-03-16T06:30:00-04:00"

  @article.comments.first.author

  => "iseasygoing"

  @article.comments.first.permalink(@article)

  => "http://www.washingtonpost.com/blogs/the-fix/post/republicans-on-the-2012-gop-field-blah/2012/03/15/gIQAT7CSFS_comment.html?commentID=washingtonpost.com/ECHO/item/1332046095-915-174"
```

See the full list of `Article` instance methods in article.rb.

For a listing of Most Viewed articles and blog posts at the time of the request:

```ruby
  require 'post_haste'
  include PostHaste

  mv = MostViewed.all
  mv.first
  => <PostHaste::MostViewed:0x007fb4e5066138 @platform="web", @type="all", @datetime=#<DateTime: 2015-09-16T17:02:00-04:00 ((2457282j,75720s,0n),-14400s,2299161j)>, @title="Boehner and his allies prepare fall battle with conservative GOP critics", @byline="Paul Kane", @url="http://www.washingtonpost.com/politics/boehner-and-his-allies-prepare-fall-battle-with-conservative-gop-critics/2015/09/15/be7b23dc-5bab-11e5-8e9e-dce8a2a2a679_story.html?tid=pm_pop", @rank=1>
```

## In the Wild

  See an example application at http://postcomments.herokuapp.com/

### Tests

To run the test suite, do:

  rake test

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
