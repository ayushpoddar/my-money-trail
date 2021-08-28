# frozen_string_literal: true

require "active_record"

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def return_success
    OpenStruct.new(success?: true, self.class.name.downcase => self)
  end

  def return_error(error_messages: [])
    error_messages = self.errors.full_messages if error_messages.blank?

    OpenStruct.new(
      success?: false,
      self.class.name.downcase => object,
      errors: error_messages
    )
  end
end
