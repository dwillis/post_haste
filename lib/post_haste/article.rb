require 'open-uri'
require 'uri'
require 'json'

module PostHaste
  class Article
    # Represents a single Washington Post story or blog post.

    attr_reader :uuid, :type, :title, :summary, :mobile_headline, :web_headline, :permalink, :short_url, :keywords, :email, :bio_page,
    :comments_url, :byline, :created_datetime, :published_datetime, :display_datetime, :updated_datetime, :section, :tags, :comments

    def initialize(params={})
      params.each_pair do |k,v|
       instance_variable_set("@#{k}", v)
      end
    end

    def self.latest_comments_url(url, limit)
      escaped_uri = URI.escape(url)
      "https://comments-api.ext.nile.works/v1/search?q=((childrenof%3A+#{escaped_uri}+source%3Awashpost.com+(((state%3AUntouched++AND+user.state%3AModeratorApproved)+OR+(state%3ACommunityFlagged%2CModeratorApproved%2CModeratorDeleted+AND+-user.state%3AModeratorBanned%2CModeratorDeleted)+)++AND+(+-markers%3Aignore+)+)+++))+itemsPerPage%3A+15+sortOrder%3AreverseChronological+safeHTML%3Aaggressive+children%3A+2+childrenSortOrder%3Achronological+childrenItemsPerPage%3A3++(((state%3AUntouched++AND+user.state%3AModeratorApproved)+OR+(state%3ACommunityFlagged%2CModeratorApproved+AND+-user.state%3AModeratorBanned%2CModeratorDeleted)+)++AND+(+-markers%3Aignore+)+)+&appkey=prod.washpost.com"
    end

    def self.parse_latest_comments(article, comments_url)
      results = JSON.parse(open(comments_url).read)
      Comment.create_comments_from_objects(article, results['entries'])
    end

    # comment limit defaults to 15, but can be set higher or lower
    def self.create_from_url(url, comment_limit=15)
      result = parse_json(get_json(url))
      create(result, comment_limit)
    end

    # Given a Washington Post story or blog url, can turn that url into a JSON API endpoint
    # returns the url and the source used in Article creation
    def self.get_json(url)
      "http://apps-origin.washingtonpost.com/f/story-builder/api/url/?url=#{url}"
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

    # creates an Article object from a JSON response
    # with 25 latest comments, can be configured.
    def self.create(result={}, limit=25)
      self.new type: result['type'],
               uuid: result['uuid'],
               title: result['title'],
               mobile_headline: result['mobile_headline'],
               web_headline: result['web_headline'],
               summary: result['summary'],
               permalink: result['_id'],
               short_url: result['short_url'],
               comments_url: latest_comments_url(result['_id'], limit),
               keywords: result['clavis_keywords'],
               byline: result['creator'].map{|c| c['name']},
               email: result['creator'].map{|c| c['email']},
               bio_page: result['creator'].map{|c| c['bio_page']},
               created_datetime: Time.at(result['created_date'].to_i),
               published_datetime: Time.at(result['published_date'].to_i),
               display_datetime: Time.at(result['display_date'].to_i),
               section: result['kicker']['name'],
               tags: result['tags'],
               comments: parse_latest_comments(result['_id'], latest_comments_url(result['_id'], limit=limit))

    end
  end
end
