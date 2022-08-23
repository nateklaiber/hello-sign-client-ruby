module HelloSign
  module Models
    class SignatureRequest
      include Comparable

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def <=>(other)
      end

      def self.list(params={})
        HelloSign::Models::SignatureRequests.list(params)
      end

      def self.retrieve(id, params={})
        HelloSign::Models::SignatureRequests.retrieve(id, params)
      end

      def signature_request_id
        @attributes['signature_request_id']
      end
      alias id signature_request_id

      def title
        @attributes['title']
      end

      def subject
        @attributes['subject']
      end

      def message
        @attributes['message']
      end

      def is_complete
        @attributes['is_complete']
      end
      alias is_complete? is_complete
      alias complete? is_complete

      def is_declined
        @attributes['is_declined']
      end
      alias is_declined? is_declined
      alias declined? is_declined

      def has_error
        @attributes['has_error']
      end
      alias has_error? has_error
      alias error? has_error
    end
  end
end
