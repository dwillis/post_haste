%w(article.rb comment.rb most_viewed.rb video.rb).each do |f|
  require File.join(File.dirname(__FILE__), 'post_haste/', f)
end
require 'httparty'
require 'uri'
require 'date'
