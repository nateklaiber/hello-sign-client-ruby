module HelloSign
  module Models
    class Metadata

      # Returns an instance of the Metadata. Since these are defined by the initial request
      # we do not know ahead of time what the fields may be.
      #
      # @param attributes [Hash]
      #
      # @return [HelloSign::Models::Metadata]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Implement method missing
      #
      # @param method_name [String] name of the attribute
      # @param args [Array] optional arguments
      #
      # @return [String,NilClass]
      def method_missing(method_name, *args)
        if @attributes.has_key?(method_name.to_s)
          @attributes[method_name.to_s]
        else
          HelloSign::Client.logger.info { "Could not find metadata attribute for %s" % [method_name.to_s] }

          nil
        end
      end
    end
  end
end
