# frozen_string_literal: true

module Browserless
  class ConfigurationError < StandardError; end

  class Configuration
    attr_writer :api_key
    attr_accessor :options, :goto_options, :emulate_media, :style_tag

    BASE_URL = "https://chrome.browserless.io/pdf?token="

    def initialize
      @api_key = nil
    end

    def api_key
      return @api_key if @api_key

      error = "Api key missing. Check if you have defined an api key in the config/browserless.rb file."
      raise ConfigurationError, error
    end

    def url
      "#{BASE_URL}#{api_key}"
    end
  end
end
