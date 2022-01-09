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
              input :description, label: "Try to describe this account in a fun way (optional)"
              input :initial_balance, required: true, convert: :float, default: 0, label: "Please enter this account's initial balance"
              yes_or_no :is_external, required: true, default: false, label: "Is this an external account?"
            end
            values
          rescue StandardError => e
            raise CollectionError, e.message
          end

          private

          def humanize
            {
              :name              => @values[:name],
              :description       => @values[:description],
              :initial_balance   => @values[:initial_balance],
              "external_account" => @values[:is_external]
            }
          end
        end
      end
    end
  end
end
