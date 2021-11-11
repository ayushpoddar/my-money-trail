# frozen_string_literal: true

require_relative "../utils/result"
require_relative "../utils/errors"

module Composites
  class Base
    include Errors

    def self.inherited(klass)
      klass.include Result
    end
  end
end
