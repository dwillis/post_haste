module PostHaste
  class Video

    attr_reader :id, :start_count, :url, :timestamp

    def initialize(params={})
      params.each_pair do |k,v|
       instance_variable_set("@#{k}", v)
      end
    end

    def self.create(results)
      results['topVideos'].map{|r| self.new(start_count: r['VideoStartCount'], id: r['videoId'], url: "https://www.washingtonpost.com/video/c/video/#{r['videoId']}", timestamp: DateTime.strptime(results['fileCreated'].to_s, '%s'))}
    end

    def self.trending_videos
      url = "https://analytics.posttv.com/trending-videos-overall.json"
      results = HTTParty.get(url).parsed_response
      create(results)
    end

  end
end
