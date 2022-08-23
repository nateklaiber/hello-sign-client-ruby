module HelloSign
  module FileStore
    class DirectoryEntries
      include Enumerable

      def initialize(collection)
        @collection = Array(collection)
      end

      def each(&block)
        internal_collection.each(&block)
      end

      def find_by_basename(basename)
        self.find { |r| r.basename.to_s == basename.to_s }
      end

      private
      def internal_collection
        @collection.map { |record| HelloSign::FileStore::DirectoryEntry.new(record) }
      end
    end
  end
end
