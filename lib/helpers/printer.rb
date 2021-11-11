require "pastel"
require "awesome_print"

module Printer
  @@pastel = Pastel.new

  def print_info(text)
    puts @@pastel.blue(text)
  end

  def print_error(text)
    puts @@pastel.red(text)
  end

  def print_success(text)
    puts @@pastel.green(text)
  end

  def print_warning(text)
    puts @@pastel.yellow(text)
  end

  def pretty_print(obj)
    ap obj, index: false, object_id: false
  end
end
