module HelloSign
  module Models
    class ListInfo
      # Returns an instance of the list info metadata
      #
      # @param attributes [Hash]
      #
      # @return [HelloSign::Models::ListInfo]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Returns the current page
      #
      # @return [Integer]
      def page
        @attributes['page']
      end

      # Returns the total number of pages
      #
      # @return [Integer]
      def num_pages
        @attributes['num_pages']
      end
      alias total_pages num_pages

      # Returns the total number of results
      #
      # @return [Integer]
      def num_results
        @attributes['num_results']
      end
      alias total_results num_results

      # Returns the page size
      #
      # @return [Integer]
      def page_size
        @attributes['page_size']
      end
      alias per_page page_size
    end
  end
end
