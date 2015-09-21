module PostHaste
  class MostViewed

    attr_reader :platform, :datetime, :title, :byline, :url, :rank, :type

    def initialize(params={})
      params.each_pair do |k,v|
       instance_variable_set("@#{k}", v)
      end
    end

    def self.all(platform='web', limit=25)
      url = "https://js.washingtonpost.com/most-viewed/#{platform}/article,blog.feed-#{limit}.json"
      create(HTTParty.get(url).parsed_response, platform, 'all')
    end

    def self.articles(platform='web', limit=25)
      url = "https://js.washingtonpost.com/most-viewed/#{platform}/article.feed-#{limit}.json"
      create(HTTParty.get(url).parsed_response, platform, 'articles')
    end

    def self.blogs(platform='web', limit=25)
      url = "https://js.washingtonpost.com/most-viewed/#{platform}/blog.feed-#{limit}.json"
      create(HTTParty.get(url).parsed_response, platform, 'blogs')
    end

    def self.create(result={}, platform, type)
      result['content'].map!.with_index {|r,i|
        self.new platform: platform,
                 type: type,
                 datetime: DateTime.parse(result['updated']),
                 title: r['linkText'],
                 byline: r['byline'],
                 url: r['url'],
                 rank: i+1
        }
    end
  end
end
