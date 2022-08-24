module HelloSign
  module Models
    class SignatureRequest
      include Comparable

      # Returns an instance of the signature request
      #
      # @param attributes [Hash]
      #
      # @return [HelloSign::Models::SignatureRequest]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Implement comparaboe
      def <=>(other)
        self.created_at <=> other.created_at
      end


      # Helper to retrieve the list
      #
      # @param params [Hash]
      #
      # @return [HelloSign::Models::SignatureRequests]
      def self.list(params={})
        HelloSign::Models::SignatureRequests.list(params)
      end

      # Helper method to retrieve the record
      #
      # @param id [String]
      # @param params [Hash]
      #
      # @return [HelloSign::Models::SignatureRequest,NilClass]
      def self.retrieve(id, params={})
        HelloSign::Models::SignatureRequests.retrieve(id, params)
      end

      # Returns the signature request id
      #
      # @return [String]
      def signature_request_id
        @attributes['signature_request_id']
      end
      alias id signature_request_id

      # Returns the title
      #
      # @return [String]
      def title
        @attributes['title']
      end

      # Returns the original title
      #
      # @return [String]
      def original_title
        @attributes['original_title']
      end

      # Returns the subject
      #
      # @return [String]
      def subject
        @attributes['subject']
      end

      # Returns the message
      #
      # @return [String]
      def message
        @attributes['message']
      end

      # Returns true if complete
      #
      # @return [Boolean]
      def is_complete
        @attributes['is_complete']
      end
      alias is_complete? is_complete
      alias complete? is_complete

      # Returns true if declined
      #
      # @return [Boolean]
      def is_declined
        @attributes['is_declined']
      end
      alias is_declined? is_declined
      alias declined? is_declined

      # Returns true if has an error
      #
      # @return [Boolean]
      def has_error
        @attributes['has_error']
      end
      alias has_error? has_error
      alias error? has_error

      # Returns true if this is a test mode
      #
      # @return [Boolean]
      def test_mode
        @attributes['test_mode']
      end
      alias is_test_mode test_mode
      alias test_mode? test_mode

      # Returns the signing url value
      #
      # @return [String]
      def signing_url_value
        @attributes['signing_url']
      end

      # Returns the signing URL
      #
      # @return [URI]
      def signing_url
        begin
          URI(self.signing_url_value)
        rescue
          nil
        end
      end

      # Returns the signing redirect value url
      #
      # @return [String]
      def signing_redirect_url_value
        @attributes['signing_redirect_url']
      end

      # Returns the signing redirect url
      #
      # @return [URI]
      def signing_redirect_url
        begin
          URI(self.signing_redirect_url_value)
        rescue
          nil
        end
      end

      # Returns the final copy URI value
      #
      # @return [String]
      def final_copy_uri_value
        @attributes['final_copy_uri']
      end

      # Returns the files url value
      #
      # @return [String]
      def files_url_value
        @attributes['files_url']
      end

      # Returns the files url
      #
      # @return [URI]
      def files_url
        begin
          URI(self.files_url_value)
        rescue
          nil
        end
      end

      # Returns the details url value
      #
      # @return [String]
      def details_url_value
        @attributes['details_url']
      end

      # Returns the details url
      #
      # @return [Uri]
      def details_url
        begin
          URI(self.details_url_value)
        rescue
          nil
        end
      end

      # Returns the requester email address value
      #
      # @return [String]
      def requester_email_address_value
        @attributes['requester_email_address']
      end

      # Returns the requester email address
      #
      # @return [HelloSign::EmailAddress]
      def requester_email_address
        HelloSign::EmailAddress.new(self.requester_email_address_value)
      end

      # Returns the signatures attributes
      #
      # @return [Array]
      def signatures_attributes
        Array(@attributes.fetch('signatures', []))
      end

      # Returns the associated signatures
      #
      # @return [HelloSign::Models::Signatures]
      def signatures
        @signatures ||= HelloSign::Models::Signatures.new(self.signatures_attributes)
      end

      # Returns true if there are any signatures
      #
      # @return [Boolean]
      def signatures?
        self.signatures.any?
      end

      # Returns the custom fields attributes
      #
      # @return [Array]
      def custom_fields_attributes
        Array(@attributes.fetch('custom_fields', []))
      end

      # Returns the custom fields
      #
      # @todo: Documentation is broken for this object. Unable to test.
      #
      # @return [HelloSign::Models::CustomFields]
      def custom_fields
        @custom_fields ||= HelloSign::Models::CustomFields.new(self.custom_fields_attributes)
      end

      # Returns true if there are custom fields
      #
      # @return [Boolean]
      def custom_fields?
        self.custom_fields.any?
      end

      # Returns the metadata attributes
      #
      # @return [Hash]
      def metadata_attributes
        Hash(@attributes.fetch('metadata', {}))
      end

      # Returns the metadata object
      #
      # @return [HelloSign::Models::Metadata]
      def metadata
        @metadata ||= HelloSign::Models::Metadata.new(self.metadata_attributes)
      end

      # Returns the created at unix timestamp
      #
      # @return [Integer]
      def created_at_unix_timestamp
        @attributes['created_at']
      end

      # Returns the created at time
      #
      # @return [Time]
      def created_at
        begin
          Time.at(self.created_at_unix_timestamp)
        rescue
          nil
        end
      end

      # Return the original attributes
      #
      # @return [Hash]
      def to_attributes
        @attributes
      end
    end
  end
end
