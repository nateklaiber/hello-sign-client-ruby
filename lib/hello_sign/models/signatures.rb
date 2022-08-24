module HelloSign
  module Models
    class Signatures
      include Enumerable

      # Returns the collection of signatures
      #
      # @param collection [Array]
      #
      # @return [HelloSign::Models::Signatures]
      def initialize(collection=[])
        @collection = Array(collection)
      end

      # Implement enumerable
      def each(&block)
        internal_collection.each(&block)
      end

      # Return attributes for all matching records by status code
      #
      # @param status_code [String]
      #
      # @return [Array<Hash>]
      def find_all_by_status_code_attributes(status_code)
        Array(self.select { |record| record.status_code_matches?(status_code) }.map(&:to_attributes))
      end
      def find_all_by_status_code_attributes(status_code)
        Array(self.select { |record| record.status_code_matches?(status_code) }.map(&:to_attributes))
      end

      # Retrieve all records by status code
      #
      # @param status_code [String]
      #
      # @return [HelloSign::Models::Signatures]
      def find_all_by_status_code(status_code)
        self.class.new(self.find_all_by_status_code_attributes(status_code))
      end

      # Find the signer by the email address
      #
      # @param email_address_value [String]
      #
      # @return [HelloSign::Models::Signature,NilClass]
      def find_by_email_address(email_address_value)
        self.find { |record| record.email_address_value == email_address_value.to_s }
      end

      # Find the signer by id
      #
      # @param id [String]
      #
      # @return [HelloSign::Models::Signature,NilClass]
      def find_by_id(id)
        self.find { |record| record.id == id.to_s }
      end

      private
      def internal_collection
        @collection.map { |record| HelloSign::Models::Signature.new(record) }
      end
    end
  end
end
