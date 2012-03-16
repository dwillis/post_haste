require 'test_helper'

class TestPostHaste::TestArticle < Test::Unit::TestCase
	include PostHaste
	
	context "Article.create" do
		setup do
		  url = "http://www.washingtonpost.com/politics/joe-biden-digging-back-into-his-roots-to-move-obama-forward/2012/03/14/gIQARwYBDS_story.html"
		  json_url = Article.get_json(url)
		  @result = Article.parse_json(json_url)
			@article = Article.create(@result)
		end
		
		should "return an object of the Article type" do
			assert_kind_of(Article, @article)
		end
		
		%w(id type title blurb).each do |attr|
			should "assign the value of the @#{attr} attribute from the '#{attr}' key in the hash" do
				assert_equal(@result['contentConfig'][attr], @article.send(attr))
			end
		end
		
  end
end