module HelloSign
  module Models
    class CustomField

      # Returns an instance of the Custom Field. Since these are custom
      # we do not know ahead of time what the fields may be
      #
      # @param attributes [Hash]
      #
      # @return [HelloSign::Models::CustomField]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end
    end
  end
end
