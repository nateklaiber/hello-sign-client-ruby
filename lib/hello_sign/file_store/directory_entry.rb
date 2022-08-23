require 'mime/types'

module HelloSign
  module FileStore
    class DirectoryEntry < SimpleDelegator
      CHUNK_SIZE = 5242880
      UNIT_BYTES = 'bytes'.freeze

      include Comparable

      def initialize(attributes={})
        @attributes = Hash(attributes)

        @_pathname = Pathname.new(self.path)
      end

      def <=>(other)
        self.created_at <=> other.created_at
      end

      def path
        @attributes[:path]
      end

      def size_unit
        Unit.new("%s %s" % [self.size, UNIT_BYTES])
      end

      def mime_types
        MIME::Types.type_for(self.to_s)
      end

      def name
        self.basename
      end

      def primary_mime_type
        self.mime_types.first
      end

      def primary_mime_type?
        !self.primary_mime_type.nil?
      end

      def created_at
        begin
          self.ctime.utc
        rescue
          nil
        end
      end

      def body
        begin
          if self.json_type?
            self.as_json
          else
            self.read
          end
        rescue
          nil
        end
      end

      def to_attributes
        @attributes
      end

      def csv_type?
        self.mime_types.any? { |r| r.like?('text/csv') }
      end

      def json_type?
        self.mime_types.any? { |r| r.like?('application/json') }
      end

      def html_type?
        self.mime_types.any? { |r| r.like?('text/html') }
      end

      def xlsx_type?
        self.mime_types.any? { |r| r.like?('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
      end

      def as_json
        if self.json_type?
          begin
            MultiJson.load(self.read)
          rescue
            []
          end
        elsif self.csv_type?
          Array(self.as_csv.map { |record| record.to_hash })
        else
          []
        end
      end

      def as_xlsx
        if self.xlsx_type?
          Roo::Excelx.new(self.path)
        end
      end

      def as_csv
        if self.csv_type?
          begin
            CSV.parse(self.read, headers: true, liberal_parsing: true)
          rescue
            ''
          end
        else
          ''
        end
      end

      def io
        @io ||= File.open(self.to_s)
      end

      def base64_encoded
        self.body.base64_encoded
      end

      def as_base64_encoded_data
        "data:%s;base64,%s" % [self.primary_mime_type, self.base64_encoded]
      end

      def checksum
        self.io.rewind

        Digest::MD5.new.tap do |checksum|
          while chunk = self.io.read(CHUNK_SIZE)
            checksum << chunk
          end

          self.io.rewind
        end.base64digest
      end

      def __getobj__
        @_pathname
      end
    end
  end
end

