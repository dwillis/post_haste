# PostHaste

A Ruby library that wraps the JSON endpoints provided for Washington Post articles and blog posts. Potentially suitable for building custom feeds of Washington Post content, in the event that you don't want to actually visit washingtonpost.com. It handles articles and blog posts from the Post's CMS (along with the most recent 15 comments from those), as well as WordPress-powered blogs, which have slightly different output.

Tested under Ruby 1.9.2 & 1.9.3.

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

  @article = Article.create_from_url(url, 25) # 25 is comment limit, default is 15.

  @article.title

  => "Republicans on the 2012 GOP field: Blah."

  @article.display_datetime.to_s

  => "2012-03-16T06:30:00-04:00"
  
  @article.comments.first.author

  => "Horatio_Swaggbottom"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
