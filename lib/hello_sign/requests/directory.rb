module HelloSign
  module Requests
    class Directory
      FILE_NAME = 'routes.json'.freeze

      def self.list(params={})
        HelloSign::FileStore::Directory.retrieve(FILE_NAME)
      end
    end
  end
end
