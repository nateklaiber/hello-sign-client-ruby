module HelloSign
  module Models
    class Directory
      include Enumerable

      def initialize(collection)
        @collection = Array(collection)
      end

      def self.list(params={})
        request = HelloSign::Requests::Directory.list(params)

        return self.new(request.body)
      end

      def each(&block)
        internal_collection.each(&block)
      end

      def to_restless_router
        routes = RestlessRouter::Routes.new

        self.each do |record|
          routes.add_route(record)
        end

        routes
      end

      private
      def internal_collection
        @collection.map { |record| HelloSign::Models::DirectoryEntry.new(record) }
      end
    end
  end
end

