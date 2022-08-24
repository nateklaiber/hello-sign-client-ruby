module HelloSign
  module Models
    class CustomFields
      include Enumerable

      # Returns an instance of the custom fields defined
      #
      # @param collection [Array]
      #
      # @return [HelloSign::Models::CustomFields]
      def initialize(collection=[])
        @collection = Array(collection)
      end

      # Implement enumerable
      def each(&block)
        internal_collection.each(&block)
      end

      private
      def internal_collection
        @collection.map { |record| HelloSign::Models::CustomField.new(record) }
      end
    end
  end
end
