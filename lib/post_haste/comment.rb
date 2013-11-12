require 'open-uri'
require 'uri'
require 'json'

module PostHaste
  class Comment
    # Represents a comment on a Washington Post story
    
    attr_reader :id, :article_url, :author, :content, :status, :published , :permalink
    
    def initialize(params={})
      params.each_pair do |k,v|
       instance_variable_set("@#{k}", v)
      end
    end
    
    def self.create_comments_from_objects(article_url, comments)
      results = []
      comments.each do |comment|
        c = Comment.new({:id => comment['object']['id'].gsub('http://',''), :article_url => article_url, :author => comment['actor']['title'], :content => comment['object']['content'], :status => comment['object']['status'], :published => DateTime.parse(comment['object']['published'])})
        results << c
      end
      results
    end
    
    def permalink
      article_url+'?commentID='+id
    end
    
  end
end