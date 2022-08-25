module HelloSign
  module Models
    class SignatureRequests
      include Enumerable

      # Returns an instance of the signature requests collection
      #
      # @param collection [Array]
      #
      # @return [HelloSign::Models::SignatureRequests]
      def initialize(collection=[])
        @collection = Array(collection)
      end

      # Implement Enumerable
      def each(&block)
        internal_collection.each(&block)
      end

      # Helper method to return the list from the request
      #
      # @param params [Hash]
      #
      # @return [HelloSign::Requests::SignatureRequests]
      def self.list(params={})
        request = HelloSign::Requests::SignatureRequests.list(params)

        request.on(:success) do |resp|
          response_body = resp.body
          model_body    = response_body.fetch('signature_requests', [])

          return self.new(model_body)
        end

        nil
      end

      # Helper method to retrieve the instance from the request
      #
      # @param id [String]
      # @param params [Hash]
      #
      # @return [HelloSign::Models::SignatureRequest,NilClass]
      def self.retrieve(id, params={})
        request = HelloSign::Requests::SignatureRequests.retrieve(id, params)

        request.on(:success) do |resp|
          response_body = resp.body
          model_body    = response_body.fetch('signature_request', {})

          return HelloSign::Models::SignatureRequest.new(model_body)
        end

        nil
      end

      # Helper method to create a new record from the request
      #
      #
      # @param record_attributes [Hash]
      # @param params [Hash]
      #
      # @return [HelloSign::Models::SignatureRequest,NilClass]
      def self.create(record_attributes={}, params={}, &block)
        request = HelloSign::Requests::SignatureRequests.create(record_attributes, params, &block)

        request.on(:success) do |resp|
          response_body = resp.body
          model_body    = response_body.fetch('signature_request', {})

          return HelloSign::Models::SignatureRequest.new(model_body)
        end

        nil
      end

      # Helper method to retrieve the instance
      #
      # @param id [String]
      # @param params [Hash]
      #
      # @raises [HelloSign::Errors::RecordNotFoundError]
      #
      # @return [HelloSign::Models::SignatureRequest]
      def self.retrieve!(id, params={})
        record = self.retrieve(id, params)

        if record.nil?
          message = "Unable to find a record for ID: %s" % [id]

          HelloSign::Client.logger.error(message)
          raise HelloSign::Errors::RecordNotFoundError.new(message)
        end

        record
      end

      private
      def internal_collection
        @collection.map { |record| HelloSign::Models::SignatureRequest.new(record) }
      end
    end
  end
end
