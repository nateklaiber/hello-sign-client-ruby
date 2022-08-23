require 'dotenv'
Dotenv.load

require 'logger'
require 'date'
require 'timezone'
require 'multi_json'
require 'restless_router'
require 'hello_sign/client/version'

require 'hello_sign/errors'
require 'hello_sign/logger'
require 'hello_sign/configuration'
require 'hello_sign/connection'
require 'hello_sign/response'

require 'hello_sign/utilities'

require 'hello_sign/file_store'

require "hello_sign/requests"
require "hello_sign/models"

module HelloSign
  module Client
    # Class accessor methods to be utilized
    # throughout the gem itself.
    class << self
      attr_accessor :configuration
      attr_accessor :routes
    end

    # Create a default Configuration to use
    # throughout the gem
    #
    # @return [HelloSign::Configuration] Configuration object utilizing the Default
    def self.configuration
      @configuration ||= HelloSign::Configuration.new
    end

    # Specify configuration options. This will be applied to
    # our memoized Configuration.
    #
    # @return [HelloSign::Configuration]
    def self.configure
      yield(self.configuration)
    end

    # Helper method to access the Connection object
    #
    # @return [HelloSign::Connection] Faraday Response Delegator
    def self.connection
      @connection ||= HelloSign::Connection.new(url: self.configuration.api_host) do |builder|
        builder.response(:json, content_type: /\bjson/)

        builder.response(:logger, self.configuration.request_logger)

        builder.adapter(HelloSign::Connection.default_adapter)

        # Inject Authorization
        builder.basic_auth(self.configuration.api_key, nil)
      end

      # Merge default headers
      @connection.headers.merge!(self.configuration.connection_options[:headers])

      @connection
    end

    # Helper method to peform a GET request
    #
    # @return [HelloSign::Response] Faraday Response Delegator
    def self.get(url, data={}, headers={})
      request = self.connection.get(url, data, headers)

      HelloSign::Response.new(request)
    end

    # Helper method to perform a HEAD request
    #
    # @return [HelloSign::Response] Faraday Response Delegator
    def self.head(url, data={}, headers={})
      request = self.connection.head(url, data, headers)

      HelloSign::Response.new(request)
    end

    # Helper method to perform a OPTIONS request
    #
    # @return [HelloSign::Response] Faraday Response Delegator
    def self.options(url, headers={})
      request = self.connection.http_options(url, nil, headers)

      HelloSign::Response.new(request)
    end

    # Helper method to perform a PUT request
    #
    # @return [HelloSign::Response] Faraday Response Delegator
    def self.put(url, data={}, headers={})
      request = self.connection.put(url, data, headers)

      HelloSign::Response.new(request)
    end

    # Helper method to perform a POST request
    #
    # @return [HelloSign::Response] Faraday Response Delegator
    def self.post(url, data={}, headers={})
      request = self.connection.post(url, data, headers)

      HelloSign::Response.new(request)
    end

    def self.delete(url, data={}, headers={})
      request = self.connection.delete(url, data, headers)

      HelloSign::Response.new(request)
    end

    # Define the API routes
    #
    # These are the endpoints that will be used to interact
    # with the API. Before you make any requests you will
    # want to add the corresponding routes here.
    #
    # @return [RestlessRouter::Routes] A collection of Routes
    def self.routes
      return @routes if @routes

      routes = HelloSign::Models::Directory.list
      routes = routes.to_restless_router

      @routes = routes
    end

    # Returns the link relationship for
    # a specified path.
    #
    # Custom link relationships are fully qualified
    # URIS, but in this case we only care to reference
    # the path and add the API host.
    #
    # @return [String]
    def self.rel_for(rel)
      "%s/%s" % [self.api_host, rel]
    end

    # Helper method to return the API version
    #
    # @return [String]
    def self.api_version
      self.configuration.api_version
    end

    # Helper method to return the API HOST
    #
    # @return [String] API URI
    def self.api_host
      self.configuration.api_host
    end
  end
end
