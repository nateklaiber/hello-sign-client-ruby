module HelloSign
  module Models
    class SignatureRequests
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def each(&block)
        internal_collection.each(&block)
      end

      def self.list(params={})
        request = HelloSign::Requests::SignatureRequests.list(params)

        request.on(:success) do |resp|
          response_body = resp.body
          model_body    = response_body.fetch('signature_requests', [])

          return self.new(model_body)
        end

        nil
      end

      def self.retrieve(id, params={})
        request = HelloSign::Requests::SignatureRequests.retrieve(id, params)

        request.on(:success) do |resp|
          response_body = resp.body
          model_body    = response_body.fetch('signature_request', {})

          return HelloSign::Models::SignatureRequest.new(model_body)
        end

        nil
      end

      private
      def internal_collection
        @collection.map { |record| HelloSign::Models::SignatureRequest.new(record) }
      end
    end
  end
end
