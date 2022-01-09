# frozen_string_literal: true

module Composites
  module Helpers
    module Backend
      module Account

        def self.to_enum(meth)
          meth = meth.to_s

          unless %w[all internal].include?(meth)
            raise ArgumentError, "#{meth} is not a supported method name"
          end
          ::Account.send(meth).map
        end

      end
    end
  end
end
