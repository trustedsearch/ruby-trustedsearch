require "addressable/uri"
require "cgi"
require "htmlentities"
require "httparty"
require "json"
require "net/http"
require "uri"
require 'digest'


# Version
require_relative "trustedsearch/version"
require_relative "trustedsearch/api_response"
require_relative "trustedsearch/api_resource"
require_relative "trustedsearch/api"
require_relative "trustedsearch/v2/v2"
require_relative "trustedsearch/v2/hooks"
require_relative "trustedsearch/v2/hook_subscriptions"
require_relative "trustedsearch/v2/locations"

require_relative "trustedsearch/errors/error"
require_relative "trustedsearch/errors/api_mock_response"
require_relative "trustedsearch/errors/authentication_error"
require_relative "trustedsearch/errors/connection_error"
require_relative "trustedsearch/errors/invalid_request_error"


module TrustedSearch

  @environments = {
    :sandbox => {
      :domain => 'http://api.sandbox.trustedsearch.org'
    },
    :production => {
      :domain => 'https://api.trustedsearch.org'
    },
    :local => {
      :domain => 'http://api.local.trustedsearch.org'
    }
  }

  @api_base_url = "https://api.trustedsearch.org"
  @api_version  = 1
  @api_timeout  = 30
  @environment = 'sandbox'

  class << self
    attr_accessor :public_key, :private_key, :api_base_url, :environment, :environments, :api_version
    attr_reader :api_timeout
  end

  def self.api_version=(version)
    raise ArgumentError, "Version must be a Fixnum (YYYYMMDD format); got #{version.class} instead." unless version.is_a? Fixnum
    raise ArgumentError, "Please provide the version of the API Key." unless version > 0
    @api_version = version
  end

  def self.api_timeout=(timeout)
    raise ArgumentError, "Timeout must be a Fixnum; got #{timeout.class} instead" unless timeout.is_a? Fixnum
    raise ArgumentError, "Timeout must be > 0; got #{timeout} instead" unless timeout > 0
    @api_timeout = timeout
  end
end