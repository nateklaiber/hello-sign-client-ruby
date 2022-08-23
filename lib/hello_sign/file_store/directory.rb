module HelloSign
  module FileStore
    class Directory
      MissingBasenameError = Class.new(StandardError)
      FileNotFoundError    = Class.new(StandardError)

      BASE_DIRECTORY = File.expand_path('../../../../data', __FILE__)

      def self.records(params={})
        Dir.glob([BASE_DIRECTORY, '*'].join('/')).map { |r| Pathname.new(r) }
      end

      def self.list_attributes(params={})
        records = self.records(params)

        records.map do |record|
          {
            :path => record.to_s
          }
        end
      end

      def self.list(params={})
        HelloSign::FileStore::DirectoryEntries.new(self.list_attributes(params))
      end

      def self.retrieve(basename, params={})
        self.list(params).find_by_basename(basename)
      end
    end
  end
end
