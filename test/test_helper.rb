require "minitest/autorun"
require 'rubygems'
require 'shoulda'
require 'json'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'post_haste'

module TestPostHaste
end
