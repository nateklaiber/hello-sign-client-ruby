require 'base64'
require 'digest'

module HelloSign
  module Extensions
    module String

      def cache_key
        Digest::SHA256.hexdigest(self)
      end

      def base64_encoded
        Base64.encode64(self)
      end
    end
  end
end



