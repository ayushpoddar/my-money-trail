require_relative "printer"
require_relative "../commands"

module ResultHandler
  include Printer

  ARTIFICIAL_DELAY = 0.5

  def ultimate_handler(result, failure_callback: nil, success_callback: nil)
    if result.success?
      handle_success(result.object, &success_callback)
    else
      handle_failure(result.errors, &failure_callback)
    end
  end

  def handle_failure(errors, &block)
    print_errors errors
    sleep ARTIFICIAL_DELAY

    run_callback &block
  end

  def handle_success(object, &block)
    text = object.class.to_s + " saved! Here are the details:"
    print_success(text)
    pp object
    sleep ARTIFICIAL_DELAY

    run_callback &block
  end

  private

  def run_callback
    if block_given?
      yield
    else
      Commands.get_command
    end
  end

  def print_errors(errors)
    print_error("Please fix the following errors:")
    Array.wrap(errors).each do |error|
      print_warning("- " + error)
    end
    puts ""
  end
end
