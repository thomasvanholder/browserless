# frozen_string_literal: true

module Browserless
  class StyleTag
    attr_reader :style_tag

    def initialize(style_tag = nil)
      @style_tag = style_tag
    end

    def to_h
      return {content: nil} if config_value.nil?

      config_value.start_with?("http") ? {url: config_value} : {content: config_value}
    end

    private

    def config_value
      style_tag || Browserless.configuration.style_tag
    end
  end
end
