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
          unless res.respond_to?(:humanize)
            meth = method(:humanize)
            res.define_singleton_method(:humanize) do
              meth.call
            end
          end
          res
        end

        define_method "#{attr}=" do |val|
          unless val.respond_to?(:humanize)
            meth = method(:humanize)
            val.define_singleton_method(:humanize) do
              meth.call
            end
          end
          instance_variable_set("@#{attr}", val)
          val
        end
      end
    end
  end
end
