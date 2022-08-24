require 'delegate'
require 'phonelib'

module HelloSign
  class PhoneNumber < SimpleDelegator
    def initialize(phone, passed_country=nil)
      @_record = ::Phonelib.parse(phone, passed_country)
    end

    def __getobj__
      @_record
    end
  end
end
