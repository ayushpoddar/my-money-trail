# frozen_string_literal: true

module Commands
  def return_success(object)
    OpenStruct.new(success?: true, object.class.name.downcase => object)
  end

  def return_error(object, error_messages: [])
    error_messages = object.errors.full_messages if error_messages.blank?

    OpenStruct.new(
      success?: false,
      object.class.name.downcase => object,
      errors: error_messages
    )
  end
end
