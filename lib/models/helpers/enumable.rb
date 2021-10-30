# frozen_string_literal: true

module Enumable

  def enumify(col_name, const_module)
    enums = const_module.constants.map { |c|
      value = const_module.const_get(c)
      [value, value]
    }.to_h

    enum col_name => enums
  end
end
