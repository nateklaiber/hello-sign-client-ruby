require File.expand_path('../configurations', __FILE__)

module HelloSign
  class Configuration
    # Connection
    attr_accessor :api_host
    attr_accessor :api_version
    attr_accessor :api_key
    attr_accessor :connection_options

    # Request
    attr_accessor :user_agent
    attr_accessor :media_type
    attr_accessor :content_type

    # Logging
    attr_accessor :request_logger
    attr_accessor :cache_logger
    attr_accessor :logger

    # Returns the set of allows configuration
    # options
    #
    # @return [Array<Symbol>] Configuration keys
    def self.keys
      @keys ||= [
        :api_host,
        :api_key,
        :api_version,
        :connection_options,
        :user_agent,
        :media_type,
        :content_type,
        :request_logger,
        :cache_logger,
        :logger
      ]
    end

    # Create a new instance of the Configuration object.
    #
    # This will be initialized with user-supplied values
    # or vall back to the Default configuration object
    #
    # @example
    #   configuration = HelloSign::Configuration.new(api_key: 'abcd')
    #
    #   configuration.api_key
    #   # => "abcd"
    #
    # @param attributes [Hash] Hash of configuration keys and values
    #
    # @return [HelloSign::Configuration] Instance of the object
    #
    def initialize(attributes={})
      self.class.keys.each do |key|
        instance_variable_set(:"@#{key}", (attributes[key] || HelloSign::Configurations::Default.options[key]))
      end
    end

    # The final set of connection options..
    #
    # @return [Hash] Connection options
    def connection_options
      {
        :headers => {
          :accept       => self.media_type,
          :user_agent   => self.user_agent,
          :content_type => self.content_type
        }
      }
    end

    # Allows you to configure the object after it's
    # been initialized.
    #
    # @return [HelloSign::Configuration] The configuration instance
    def configure(&block)
      yield(self)
    end

    # This allows you to reset your configuration back to the
    # default state
    #
    # @return [HelloSign::Configuration] The configuration with Defaults applied
    def reset!
      self.class.keys.each do |key|
        instance_variable_set(:"@#{key}", HelloSign::Configurations::Default.options[key])
      end
    end
    alias :setup :reset!
  end
end
