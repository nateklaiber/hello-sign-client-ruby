require File.expand_path('../../logger', __FILE__)

module HelloSign
  module Configurations
    # This module is meant to store all default
    # configuration options that will be utilized
    # throughout the gem.
    #
    # These are all over-rideable through the `configure`
    # interface
    #
    module Default
      API_HOST     = 'https://api.hellosign.com'.freeze
      USER_AGENT   = ("HelloSign Ruby Gem %s" % [HelloSign::Client::VERSION]).freeze
      MEDIA_TYPE   = 'application/json'.freeze
      CONTENT_TYPE = 'application/json'.freeze
      API_VERSION  = 'v3'.freeze

      # Return the collection of default options and values
      #
      # @return [Hash] Keys and Values of default configuration
      def self.options
        Hash[HelloSign::Configuration.keys.map { |key| [key, __send__(key)] }]
      end

      # Return the ENV access token or nil
      #
      # @return [String, Nil]
      def self.api_key
        ENV['HELLO_SIGN_API_KEY']
      end

      # Return the ENV API Host or the default production
      # API host.
      #
      # @return [String]
      def self.api_host
        ENV['HELLO_SIGN_API_HOST'] || API_HOST
      end

      # Return the ENV API version or the default version
      #
      # @return [String]
      def self.api_version
        ENV['HELLO_SIGN_API_VERSION'] || API_VERSION
      end

      # Return the ENV Accept header or
      # default constant.
      #
      # @return [String]
      def self.media_type
        ENV['HELLO_SIGN_MEDIA_TYPE'] || MEDIA_TYPE
      end

      # Return the ENV Content-Type header or
      # default constant.
      #
      # @return [String]
      def self.content_type
        ENV['HELLO_SIGN_CONTENT_TYPE'] || CONTENT_TYPE
      end

      # Return the ENV User-Agent header or
      # default constant.
      #
      # @return [String]
      def self.user_agent
        ENV['HELLO_SIGN_USER_AGENT'] || USER_AGENT
      end

      # Return the Default HelloSign Logger to STDOUT.
      #
      # The default logger for Faraday to log requests.
      #
      # @return [HelloSign::Logger] Logger Delegator
      def self.request_logger
        HelloSign::Logger.new(STDOUT)
      end

      # Return the Default HelloSign Logger to STDOUT.
      #
      # If caching is enabled, this is the default logger.
      #
      # @return [HelloSign::Logger] Logger Delegator
      def self.cache_logger
        HelloSign::Logger.new(STDOUT)
      end

      # Return the Default HelloSign Logger to STDOUT.
      #
      # This is for application level logging.
      #
      # @return [HelloSign::Logger] Logger Delegator
      def self.logger
        HelloSign::Logger.new(STDOUT)
      end

      # Returns a set of default connection options.
      #
      # This will be deep merged with user-specified
      # values
      #
      # @return [Hash] Connection Options
      def self.connection_options
        {
          :headers => {
            :accept       => self.media_type,
            :user_agent   => self.user_agent,
            :content_type => self.content_type
          }
        }
      end
    end
  end
end
