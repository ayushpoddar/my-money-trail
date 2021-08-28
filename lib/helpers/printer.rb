require "pastel"

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
end
