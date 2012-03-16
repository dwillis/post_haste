require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'json'

%w(article).each do |f|
  require File.join(File.dirname(__FILE__), '../lib/post_haste', f)
end

module TestPostHaste
end
