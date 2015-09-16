module PostHaste
  class MostViewed

    attr_reader :platform, :datetime, :title, :byline, :url

    def initialize(params={})
      params.each_pair do |k,v|
       instance_variable_set("@#{k}", v)
      end
    end

    def self.all(platform='web', limit=25)
      url = "http://js.washingtonpost.com/most-viewed/#{platform}/article,blog.feed-#{limit}.json"
      create(HTTParty.get(url).parsed_response, platform)
    end

    def self.articles(platform='web', limit=25)
      url = "http://js.washingtonpost.com/most-viewed/#{platform}/article.feed-#{limit}.json"
      create(HTTParty.get(url).parsed_response, platform)
    end

    def self.blogs(platform='web', limit=25)
      url = "http://js.washingtonpost.com/most-viewed/#{platform}/blog.feed-#{limit}.json"
      create(HTTParty.get(url).parsed_response, platform)
    end

    def self.create(result={}, platform)
      result['content'].map{|r|
        self.new platform: platform,
                 datetime: DateTime.parse(result['updated']),
                 title: r['linkText'],
                 byline: r['byline'],
                 url: r['url']
        }
    end
  end
end
