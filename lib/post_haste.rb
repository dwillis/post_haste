%w(article.rb comment.rb).each do |f|
  require File.join(File.dirname(__FILE__), 'post_haste/', f)
end