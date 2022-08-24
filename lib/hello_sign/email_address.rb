require 'delegate'
require 'email_address'

module HelloSign
  class EmailAddress < SimpleDelegator

    def initialize(email_address, config={}, locale="en")
      @_record = ::EmailAddress.new(email_address, config, locale)
    end

    def __getobj__
      @_record
    end
  end
end
