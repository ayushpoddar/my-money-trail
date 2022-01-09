# frozen_string_literal: true

require_relative "../../../base_frontend"
require_relative "../../../helpers/backend/account"

module Composites
  module Transactions
    module QuickAdd
      module Frontend
        class CollectExpenseData < BaseFrontend
          DEFAULT_ACC_NAME = "cash"

          humanize :values

          def initialize(vals={})
            @values = vals
          end

          def call
            @values = collect_info(@values) do
              choice :account_id, required: true, label: "Please select the account", choices: account_choices
              input :amount, required: true, convert: :float, label: "What was the transaction amount?"
              input :summary, required: false, label: "What was the transaction about?"
              input :performed_date, convert: :date, default: Date.today.strftime("%d/%-m/%Y"), label: "Date of this transaction"
              input :performed_time, convert: :time, default: Time.current.strftime("%H:%M:%S"), label: "Time of this transaction"
            end
            set_performed_at!
            values
          rescue StandardError => e
            raise CollectionError, e.message
          end

          private

          def account_choices
            @account_choices ||= Helpers::Backend::Account.to_enum(:internal).map do |a|
              opts = { name: a.name, value: a.id }
              opts[:default] = (a.name.downcase == DEFAULT_ACC_NAME)
              opts
            end
          end

          def set_performed_at!
            date = @values[:performed_date]
            time = @values[:performed_time]

            @values[:performed_at] = Time.new(date.year, date.month, date.day, time.hour, time.min, time.sec)
          end

          def humanize
            {
              summary: @values[:summary],
              amount: "Rs #{@values[:amount]}",
              time: @values[:performed_at],
              account: account_choices.find { |a| a[:value] == @values[:account_id] }[:name]
            }
          end
        end
      end
    end
  end
end
