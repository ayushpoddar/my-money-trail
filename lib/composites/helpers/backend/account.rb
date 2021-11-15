# frozen_string_literal: true

module Composites
  module Helpers
    module Backend
      class Account

        def all_to_enum
          ::Account.all.map
        end

      end
    end
  end
end
