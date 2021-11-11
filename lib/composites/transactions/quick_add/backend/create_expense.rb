require_relative "../../../base"

module Composites
  module Transactions
    module QuickAdd
      module Backend
        class CreateExpense < Base
          # Keys required in params:
          # - summary, performed_at, account_id, :amount
          def initialize(params)
            @params = params
          end

          def call
            ActiveRecord::Base.transaction do
              acc_txn = create_account_transaction!
              event   = create_event!
              create_transaction!(event, acc_txn)
            end
          rescue StandardError => e
            raise ValidationError, e.message
          end

          private

          def create_account_transaction!
            acc_txn            = AccountTransaction.new(transaction_params)
            acc_txn.status     = AccountTransaction::Status::CONFIRMED
            acc_txn.direction  = AccountTransaction::Direction::EXPENSE
            acc_txn.account_id = @params[:account_id]
            acc_txn.save!
            acc_txn
          end

          def create_event!
            event             = Event.new
            event.summary     = @params[:summary]
            event.started_at  = @params[:performed_at]
            event.finished_at = @params[:performed_at]
            event.save!
            event
          end

          def create_transaction!(event, account_transaction)
            txn                     = Transaction.new(transaction_params)
            txn.direction           = Transaction::Direction::EXPENSE
            txn.event               = event
            txn.account_transaction = account_transaction
            txn.save!
            txn
          end

          def transaction_params
            @params.slice(:summary, :performed_at, :amount)
          end
        end
      end
    end
  end
end
