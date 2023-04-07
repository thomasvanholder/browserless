require "test_helper"

class Browserless::ConfigurationTest < Minitest::Test
  def setup
    @configuration = Browserless::Configuration.new
  end

  def test_api_key_accessor
    api_key = "test_key"

    @configuration.api_key = api_key

    assert_equal api_key, @configuration.api_key
  end

  def test_missing_api_key_raises_error
    assert_raises(Browserless::ConfigurationError) do
      @configuration.api_key
    end
  end

  def test_options_accessor
    example_options = {display_header_footer: true, landscape: false}

    @configuration.options = example_options

    assert_equal example_options, @configuration.options
  end

  def test_url_with_api_key
    @configuration.api_key = "test_key"

    assert_equal "https://chrome.browserless.io/pdf?token=test_key", @configuration.url
  end
end
