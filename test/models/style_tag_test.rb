require "test_helper"

class StyleTagTest < Minitest::Test
  def setup
    Browserless.configure do |config|
      config.api_key = "test_key"
    end
  end

  def teardown
    Browserless.configure { nil }
  end

  def test_to_h_with_url
    style_tag = Browserless::StyleTag.new("http://example.com/styles.css")

    assert_equal({url: "http://example.com/styles.css"}, style_tag.to_h)
  end

  def test_to_h_with_content
    style_tag = Browserless::StyleTag.new("body { font-family: Arial; }")

    assert_equal({content: "body { font-family: Arial; }"}, style_tag.to_h)
  end
end
