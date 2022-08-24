module HelloSign
  module Models
    class Signature
      include Comparable

      # Returns an instance of the signature
      #
      # @param attributes [Hash]
      #
      # @return [HelloSign::Models::Signature]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Implement comparable
      def  <=>(other)
        self.order <=> other.order
      end

      # Returns the signature id
      #
      # @return [String]
      def signature_id
        @attributes['signature_id']
      end
      alias id signature_id

      # Returns true if it has a pin
      #
      # @return [Boolean]
      def has_pin
        @attributes['has_pin']
      end
      alias has_pin? has_pin

      # Returns true if it has sms auth
      #
      # @return [Boolean]
      def has_sms_auth
        @attributes['has_sms_auth']
      end
      alias has_sms_auth? has_sms_auth

      # Returns true if it has sms delivery
      #
      # @return [Boolean]
      def has_sms_delivery
        @attributes['has_sms_delivery']
      end
      alias has_sms_delivery? has_sms_delivery

      # Returns the SMS phone number value
      #
      # @return [String]
      def sms_phone_number_value
        @attributes['sms_phone_number']
      end

      # Returns true if there is a phone number value
      #
      # @return [Boolean]
      def sms_phone_number_value?
        !self.sms_phone_number_value.nil?
      end

      # Returns the SMS phone number
      #
      # @return [HelloSign::PhoneNumber,NilClass]
      def sms_phone_number
        if self.sms_phone_number_value?
          HelloSign::PhoneNumber.new(self.sms_phone_number_value)
        end
      end

      # Returns true if there is an SMS phone number
      #
      # @return [Boolean]
      def sms_phone_number?
        !self.sms_phone_number.nil?
      end

      # Returns the signer email address value
      #
      # @return [String]
      def signer_email_address_value
        @attributes['signer_email_address']
      end
      alias email_address_value signer_email_address_value

      # Returns the signer email address
      #
      # @return [HelloSign::EmailAddress]
      def signer_email_address
        HelloSign::EmailAddress.new(self.signer_email_address_value)
      end
      alias email_address signer_email_address

      # Returns the signer name
      #
      # @return [String]
      def signer_name
        @attributes['signer_name']
      end
      alias name signer_name

      # Returns the signer role
      #
      # @return [String]
      def signer_role
        @attributes['signer_role']
      end
      alias role signer_role

      # Returns the order for this signer
      #
      # @return [Integer]
      def order
        @attributes.fetch('order', 0)
      end

      # Returns the status code value
      #
      # @note: Ultimately we would want an API endpoint for these, but we have
      # to discover them as we get them. They aren't available
      # in their API documentation.
      #
      # @return [String]
      def status_code_value
        @attributes['status_code']
      end

      # Returns the status code
      #
      # @return [HelloSign::Models::SignatureStatusCode,NilClass]
      def status_code
        HelloSign::Models::SignatureStatusCodes.retrieve(self.status_code_value)
      end

      # Returns true if we have a status code
      #
      # @return [Boolean]
      def status_code?
        !self.status_code.nil?
      end

      # Returns true if the status code matches this status
      #
      # @return [Boolean]
      def status_code_matches?(status_code)
        self.status_code.key_name == status_code.to_s
      end

      # Returns the signed at unix timestamp
      #
      # @return [Integer]
      def signed_at_unix_timestamp
        @attributes['signed_at']
      end

      # Returns the signed at time with zone
      #
      # @return [Time]
      def signed_at
        begin
          Time.at(self.signed_at_unix_timestamp)
        rescue
          nil
        end
      end

      # Returns the last viewed at unix timestamp
      #
      # @return [Integer]
      def last_viewed_at_unix_timestamp
        @attributes['last_viewed_at']
      end

      # Returns the last viewed at time with zone
      #
      # @return [Time]
      def last_viewed_at
        begin
          Time.at(self.last_viewed_at_unix_timestamp)
        rescue
          nil
        end
      end

      # Returns the last reminded at unix timestamp
      #
      # @return [Integer]
      def last_reminded_at_unix_timestamp
        @attributes['last_reminded_at']
      end

      # Returns the last reminded at time with zone
      #
      # @return [Time]
      def last_reminded_at
        begin
          Time.at(self.last_reminded_at_unix_timestamp)
        rescue
          nil
        end
      end

      # Returns any associated error
      #
      # @return [String]
      def error
        @attributes['error']
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
