require 'test_helper'

class TestPostHaste::TestMostViewed < Minitest::Test
  include PostHaste

  context "MostViewed.create from articles on web" do
    setup do
      @mv = MostViewed.articles
    end

    should "return an object of the Article type" do
      assert_equal(@mv.size, 25)
      assert_kind_of(MostViewed, @mv.first)
      assert_equal(@mv.first.platform, 'web')
    end
  end

  context "MostViewed.create from blogs on mobile" do
    setup do
      @mv = MostViewed.blogs('mobile', 5)
    end

    should "return an object of the Article type" do
      assert_kind_of(MostViewed, @mv.first)
      assert_equal(@mv.first.platform, 'mobile')
      assert_equal(@mv.size, 5)
    end
  end
end
