module HelloSign
  module Models
    class SignatureStatusCodes
      include Enumerable

      # Returns an instance of the available signature status codes
      #
      # @param collection [Array]
      #
      # @return [HelloSign::Models::SignatureStatusCodes]
      def initialize(collection)
        @collection = Array(collection)
      end

      # Retrieve the list from the request
      #
      # @param params [Hash]
      #
      # @return [HelloSign::Models::SignatureStatusCodes]
      def self.list(params={})
        request = HelloSign::Requests::SignatureStatusCodes.list(params)

        return self.new(request.body)
      end

      # Retrieve a specific record by id (key name)
      #
      # @param id [String]
      # @param params [Hash]
      #
      # @return [HelloSign::Models::SignatureStatusCode, NilClass]
      def self.retrieve(id, params={})
        records = self.list(params)
        records.find_by_id(id)
      end

      # Implement enumerable
      def each(&block)
        internal_collection.each(&block)
      end

      # Retrieve the record by the ID
      #
      # @param key_name [String]
      #
      # @return [HelloSign::Models::SignatureStatusCode,NilClass]
      def find_by_key_name(key_name)
        self.find { |record| record.key_name.to_s == key_name.to_s }
      end
      alias find_by_id find_by_key_name

      private
      def internal_collection
        @collection.map { |record| HelloSign::Models::SignatureStatusCode.new(record) }
      end

      def self.list_attributes(params={})
        HelloSign::Requests::SignatureStatusCodes.list(params)
      end
    end
  end
end

