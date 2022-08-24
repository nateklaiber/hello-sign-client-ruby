module HelloSign
  module Requests
    class SignatureStatusCodes
      FILE_NAME = 'signature_status_codes.json'.freeze

      def self.list(params={})
        HelloSign::FileStore::Directory.retrieve(FILE_NAME)
      end
    end
  end
end
