require 'rubygems'
require 'open-uri'
require 'date'
require 'json'

# Represents a single Washington Post story or blog post.
module PostHaste
  class Article
  
    attr_reader :id, :type, :title, :blurb, :has_correction, :correction, :has_clarification, :clarification, :permalink, :short_url, :email_url,
    :comments_url, :graphic_url, :video_url, :byline, :organization, :credits, :created_datetime, :published_datetime, :display_datetime, :updated_datetime,
    :section, :tags
   
    def initialize(params={})
      params.each_pair do |k,v|
       instance_variable_set("@#{k}", v)
      end
    end
  
    # Given a Washington Post story or blog url, can turn that url into a JSON API endpoint
    def self.get_json(url)
      url.gsub('_story','_json') if url.include?("_story")
      url.gsub('_blog','_json') if url.include?("_blog")
    end
    
    # parses a Washington Post story or blog JSON response
    def self.parse_json(url)
      JSON.parse(open(url).read)
    end
    
    # Post CMS produces unix timestamps, but with extra zeroes
    def self.parse_datetime(seconds)
      seconds = seconds.to_s.first(10)
      Time.at(seconds).to_datetime
    end
    
    # creates an Article object from a JSON response
    def self.create(params={})
      self.new :type => params['contentConfig']['type'],
               :id => params['contentConfig']['uuid'],
               :title => params['contentConfig']['title'],
               :blurb => params['contentConfig']['blurb'],
               :has_correction => params['contentConfig']['hasCorrection'],
               :correction => params['contentConfig']['correction'],
               :has_clarification => params['contentConfig']['hasClarification'],
               :clarification => params['contentConfig']['clarification'],
               :permalink => params['contentConfig']['permaLinkURL'],
               :short_url => params['contentConfig']['shortURL'],
               :email_url => params['contentConfig']['emailURL'],
               :comments_url => params['contentConfig']['commentsURL'],
               :graphic_url => params['contentConfig']['graphicURL'],
               :video_url => params['contentConfig']['videoURL'],
               :byline => params['contentConfig']['credits'].first['name'],
               :organization => params['contentConfig']['credits'].first['organization'],
               :credits => params['contentConfig']['credits'].first['credit'],
               :created_datetime => parse_datetime(params['contentConfig']['dateConfig']['dateCreated']),
               :published_datetime => parse_datetime(params['contentConfig']['dateConfig']['datePublished']),
               :display_datetime => parse_datetime(params['contentConfig']['dateConfig']['displayDate']),
               :updated_datetime => parse_datetime(params['contentConfig']['dateConfig']['dateUpdated']),
               :section => params['metaConfig']['section'],
               :tags => params['metaConfig']['tags']
      
      
    end
  end
end