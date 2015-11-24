module PostHaste
  class Video

    attr_reader :id, :start_count, :url, :timestamp, :json_url

    def initialize(params={})
      params.each_pair do |k,v|
       instance_variable_set("@#{k}", v)
      end
    end

    def self.create(results)

    end

    def self.trending_videos
      url = "https://analytics.posttv.com/trending-videos-overall.json"
      results = HTTParty.get(url).parsed_response
      results['topVideos'].map{|r| { start_count: r['VideoStartCount'], id: r['videoId'], url: MetaInspector.new("https://www.washingtonpost.com/video/c/video/#{r['videoId']}").canonicals.first[:href], timestamp: DateTime.strptime(results['fileCreated'].to_s, '%s')}}
    end

  end
end
