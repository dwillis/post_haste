require 'open-uri'
require 'uri'
require 'json'

module PostHaste
  class Comment
    
    attr_reader :id, :article_url, :author, :content, :status, :published 
    
    def initialize(params={})
      params.each_pair do |k,v|
       instance_variable_set("@#{k}", v)
      end
    end
    
    def self.create_comments_from_objects(article_url, comments)
      results = []
      comments.each do |comment|
        c = Comment.new({:id => comment['object']['id'], :article_url => article_url, :author => comment['actor']['title'], :content => comment['object']['content'], :status => comment['object']['status'], :published => DateTime.parse(comment['object']['published'])})
        results << hash
      end
      results
    end
    
  end
end