require "test_helper"

class StyleTagsTest < Minitest::Test
  def setup
    Browserless.configure do |config|
      config.api_key = "test_key"
    end
  end

  def teardown
    Browserless.configure { nil }
  end

  def test_to_a_with_url
    style_tag = Browserless::StyleTags.new("http://example.com/styles.css")
    assert_equal([{url: "http://example.com/styles.css"}], style_tag.to_a)
  end

  def test_to_a_with_content
    style_tag = Browserless::StyleTags.new("body { font-family: Arial; }")
    assert_equal([{content: "body { font-family: Arial; }"}], style_tag.to_a)
  end

  def test_to_a_with_url_and_content
    style_tag = Browserless::StyleTags.new(["http://example.com/styles.css", "body { font-family: Arial; }"])

    assert_equal([
      {url: "http://example.com/styles.css"},
      {content: "body { font-family: Arial; }"}
    ], style_tag.to_a)
  end
end
