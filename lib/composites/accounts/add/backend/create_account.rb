# frozen_string_literal: true

require_relative "../../../base"

module Composites
  module Accounts
    module Add
      module Backend
        class CreateAccount < Base
          # Keys required in params:
          # - name, initial_balance
          def initialize(params)
            @params = params
          end

          def call
            ActiveRecord::Base.transaction do
              Account.create!(account_params)
            end
          rescue StandardError => e
            raise ValidationError, e.message
          end

          private

          def account_params
            @params.slice(:name, :initial_balance, :is_external)
          end
        end
      end
    end
  end
end
