require 'base64'
require 'digest'
require 'mime/types'

module HelloSign
  class ResourceIo
    CHUNK_SIZE = 5242880
    UNIT_BYTES = 'bytes'.freeze

    AVAILABLE_ENCODINGS = ['base64']

    # Returns an instance of the IO
    #
    # @param content_type [String] The Mime Type
    # @param content_encoding [String] The encoding of the file
    # @param content_body [String,IO] The body of the file
    #
    # @return [HelloSign::ResourceIo]
    def initialize(content_type, content_encoding, content_body, &block)
      @content_type     = content_type
      @content_encoding = content_encoding
      @content_body     = content_body
    end

    # Returns the IO object from the decoded body
    #
    # @return [StringIO]
    def io
      if self.decoded_content_body.kind_of?(StringIO)
        self.decoded_content_body
      elsif self.decoded_content_body.kind_of?(IO)
        self.decoded_content_body
      elsif self.decoded_content_body.kind_of?(String)
        StringIO.new(self.decoded_content_body)
      end
    end

    # Returns true if there is an IO
    #
    # @return [Boolean]
    def io?
      !self.io.nil?
    end

    # Returns the content type (mime type)
    #
    # @return [String]
    def content_type
      @content_type
    end

    # Returns the content body
    #
    # @return [String]
    def content_body
      @content_body
    end

    # Returns the content encoding
    #
    # @return [String]
    def content_encoding
      @content_encoding
    end

    # Returns the decoded content body
    #
    # For now this only supports Base64 and Base64 data. All others
    # are assumed to be the string
    #
    # @return [String]
    def decoded_content_body
      case(self.content_encoding)
      when('base64')
        if encoding_prefix_regex.match(self.content_body)
          self.content_body[self.encoding_prefix.length..-1]
        else
          Base64.decode64(self.content_body)
        end
      else
        self.content_body
      end
    end

    # Read the IO object and extend the string with helper methods
    #
    # @return [String]
    def read
      self.io.read.extend(HelloSign::Extensions::String)
    end
    alias body read

    # Returns the mime types
    #
    # @return [Array<MIME::Type>]
    def mime_types
      MIME::Types[self.content_type]
    end

    # Returns the primary mime type
    #
    # @return [Mime::Type]
    def primary_mime_type
      self.mime_types.first
    end

    # Returns true if there is a mime type
    #
    # @return [Boolean]
    def primary_mime_type?
      !self.primary_mime_type.nil?
    end

    # Returns the base64 encoded body
    #
    # @return [String]
    def base64_encoded
      self.body.base64_encoded
    end

    # Returns the encoding prefix
    #
    # @return [String]
    def encoding_prefix
      "data:%s;base64," % [self.primary_mime_type]
    end

    # Returns the resource as a base64 encoded data file
    #
    # @return [String]
    def as_base64_encoded_data
      [self.encoding_prefix, self.base64_encoded].join
    end

    # Returns the checksum of the resource
    #
    # @return [String]
    def checksum
      Digest::MD5.new.tap do |checksum|
        while chunk = self.io.read(CHUNK_SIZE)
          checksum << chunk
        end

        self.io.rewind
      end.base64digest
    end

    private
    def encoding_prefix_regex
      Regexp.new(self.encoding_prefix)
    end
  end
end

