require 'open-uri'
require 'json'

module PostHaste
  class Article
    # Represents a single Washington Post story or blog post.
  
    attr_reader :uuid, :type, :title, :blurb, :has_correction, :correction, :has_clarification, :clarification, :permalink, :short_url, :email_url,
    :comments_url, :graphic_url, :video_url, :byline, :organization, :credits, :created_datetime, :published_datetime, :display_datetime, :updated_datetime,
    :section, :tags
   
    def initialize(params={})
      params.each_pair do |k,v|
       instance_variable_set("@#{k}", v)
      end
    end
    
    def self.create_from_url(url)
      json_url, source = get_json(url)
      result = parse_json(json_url)
      create_from_source(source, result)
    end
  
    # Given a Washington Post story or blog url, can turn that url into a JSON API endpoint
    # returns the url and a source (cms or wordpress) used in Article creation
    def self.get_json(url)
      if url.include?('/wp/')
        [url+'?json=1', 'wordpress']
      elsif url.include?("_story")
        [url.gsub('_story','_json'), 'cms']
      elsif url.include?("_blog")
        [url.gsub('_blog','_json'), 'cms']
      end
    end
    
    # parses a Washington Post story or blog JSON response
    def self.parse_json(url)
      JSON.parse(open(url).read)
    end
    
    # Post CMS produces unix timestamps, but with extra zeroes
    def self.parse_datetime(seconds)
      seconds = seconds.to_s[0..9]
      Time.at(seconds.to_i).to_datetime
    end
    
    def self.create_from_source(source, result)
      if source == 'cms'
        create(result)
      elsif source == 'wordpress'
        create_from_wordpress(result)
      end
    end
    
    # creates an Article object from a JSON response
    def self.create(params={})
      self.new :type => params['contentConfig']['type'],
               :uuid => params['contentConfig']['uuid'],
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
    
    # creates an Article object from a WordPress JSON response
    def self.create_from_wordpress(params={})
      self.new :type => params['post']['type'],
               :uuid => params['post']['id'],
               :title => params['post']['title'],
               :blurb => params['post']['excerpt'],
               :has_correction => nil,
               :correction => nil,
               :has_clarification => nil,
               :clarification => nil,
               :permalink => params['post']['url'],
               :short_url => nil,
               :email_url => nil,
               :comments_url => params['post']['url'],
               :graphic_url => nil,
               :video_url => nil,
               :byline => params['post']['author']['name'],
               :organization => nil,
               :credits => nil,
               :created_datetime => parse_datetime(params['post']['date']),
               :published_datetime => parse_datetime(params['post']['date']),
               :display_datetime => parse_datetime(params['post']['modified']),
               :updated_datetime => parse_datetime(params['post']['modified']),
               :section => nil,
               :tags => params['post']['tags']
      
    end    

  end
end