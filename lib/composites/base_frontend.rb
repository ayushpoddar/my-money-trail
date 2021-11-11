# frozen_string_literal: true

require_relative "../helpers/input"
require_relative "base"

module Composites
  class BaseFrontend < Base
    include Input

    def self.humanize(*attrs)
      attrs.each do |attr|
        define_method attr do
          res = instance_variable_get("@#{attr}")
          meth = method(:humanize)
          res.define_singleton_method(:humanize) do
            meth.call
          end
          res
        end
      end
    end
  end
end
