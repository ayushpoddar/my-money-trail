# frozen_string_literal: true

require_relative "../../../base_frontend"

module Composites
  module Accounts
    module Add
      module Frontend
        class CollectAccountData < BaseFrontend
          humanize :values

          def initialize(vals={})
            @values = vals
          end

          def call
            @values = collect_info(@values) do
              input :name, required: true, label: "Please enter the account name"
              input :initial_balance, required: true, convert: :float, label: "Please enter this account's initial balance"
            end
            values
          rescue StandardError => e
            raise CollectionError, e.message
          end

          private

          def humanize
            {
              :name            => @values[:name],
              :initial_balance => @values[:initial_balance]
            }
          end
        end
      end
    end
  end
end
