require 'test_helper'

class TestPostHaste::TestArticle < Test::Unit::TestCase
  include PostHaste
  
  context "Article.create from article" do
    setup do
      url = "http://www.washingtonpost.com/politics/joe-biden-digging-back-into-his-roots-to-move-obama-forward/2012/03/14/gIQARwYBDS_story.html"
      json_url = Article.get_json(url)
      @result = Article.parse_json(json_url)
      @article = Article.create(@result)
    end
    
    should "return an object of the Article type" do
      assert_kind_of(Article, @article)
      assert_equal(@article.type, 'article')
    end
    
    %w(uuid type title summary).each do |attr|
      should "assign the value of the @#{attr} attribute from the '#{attr}' key in the hash" do
        assert_equal(@result[attr], @article.send(attr))
      end
    end
  end

  context "Article.create from blog post" do
    setup do
      url = "http://www.washingtonpost.com/blogs/the-fix/post/republicans-on-the-2012-gop-field-blah/2012/03/15/gIQAT7CSFS_blog.html"
      json_url = Article.get_json(url)
      @result = Article.parse_json(json_url)
      @article = Article.create(@result)
    end
    
    should "return an object of the Article type" do
      assert_kind_of(Article, @article)
      assert_equal(@article.type, 'article')
    end
    
    %w(uuid type title summary).each do |attr|
      should "assign the value of the @#{attr} attribute from the '#{attr}' key in the hash" do
        assert_equal(@result[attr], @article.send(attr))
      end
    end
  end
  
  context "Article.create from Wordpress blog post" do
    setup do
      url = "http://www.washingtonpost.com/blogs/wonkblog/wp/2013/01/18/breaking-inside-the-feds-2007-crisis-response/"
      json_url = Article.get_json(url)
      @result = Article.parse_json(json_url)
      @article = Article.create(@result)
    end
    
    should "return an object of the Article type" do
      assert_kind_of(Article, @article)
      assert_equal(@article.type, 'blog')
    end
    

  end
  
end