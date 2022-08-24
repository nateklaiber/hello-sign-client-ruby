module HelloSign
  module Models
    class SignatureStatusCode

      # Returns an instance of the signature status codes
      #
      # @param attributes [Hash]
      #
      # @return [HelloSign::Models::SignatureStatusCode]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Returns the name
      #
      # @returns [String]
      def name
        @attributes['name']
      end

      # Returns the key name returned in the API
      #
      # @return [String]
      def key_name
        @attributes['key_name']
      end

      # Returns the original attributes
      #
      # @return [Hash]
      def to_attributes
        @attributes
      end
    end
  end
end
