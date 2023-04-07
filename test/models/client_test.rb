require "test_helper"

class Browserless::ClientTest < Minitest::Test
  def setup
    Browserless.configure do |config|
      config.api_key = "test_key"
    end
  end

  def teardown
    Browserless.configure { nil }
  end

  def test_headers
    expected_headers = {
      "Cache-Control": "no-cache",
      "Content-Type": "application/json"
    }
    assert_equal expected_headers, Browserless::Client.headers
  end

  def test_initialize
    client = Browserless::Client.new(html: "<html></html>")

    assert_equal "<html></html>", client.html
    assert_equal "screen", client.emulate_media
    assert_equal({content: nil}, client.style_tag)
    assert_equal Browserless.configuration.url, client.url
  end

  def test_existing_browserless_api_key
    client = Browserless::Client.new(html: "<html></html>")

    assert_raises("Unauthorized. Please check if you have a valid Browserless API key") do
      client.to_pdf
    end
  end

  def test_initialize_with_style_tag
    client = Browserless::Client.new(html: "<html></html>", style_tag: "body { font-family: Arial; }")

    assert_equal({content: "body { font-family: Arial; }"}, client.style_tag)
  end

  def test_initialize_with_custom_options
    Browserless.configure do |config|
      config.api_key = "test_key"
      config.options = {}
    end

    client = Browserless::Client.new(
      html: "<html></html>",
      emulate_media: "print",
      options: {display_header_footer: true}
    )

    assert_equal "<html></html>", client.html
    assert_equal "print", client.emulate_media
    assert_equal({
      landscape: false,
      displayHeaderFooter: true,
      printBackground: false,
      margin: {},
      format: "A4",
      headerTemplate: "<div></div>",
      footerTemplate: "<div style='font-size: 11px; margin-left: 40px; font: Helvetica'><span class='pageNumber'></span> of <span class='totalPages'></span></div>"
    }, client.options)
  end
end
