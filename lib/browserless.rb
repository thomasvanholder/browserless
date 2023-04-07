# frozen_string_literal: true

require "debug"
require "json"
require "httparty"

require_relative "browserless/version"
require_relative "browserless/configuration"
require_relative "browserless/client"

module Browserless
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
