require_relative "printer"
require_relative "form_builder"

module Input
  include Printer

  # Select an option out of multiple possibilities
  # @param possibilities [Array<String>]
  # @param multiple [Boolean] if you want multiple selections possible
  # @return [Array<String>]
  def select_option(info_text, possibilities, multiple: false)
    print_info info_text
    with_fzf_filter(multiple: multiple) do
      puts possibilities
    end
  end

  # Collects information from the user
  # @param [Hash] values - All the initial values for the form fields
  # Example values: { name: "Kotak Bank", initial_balance: 50 }
  # @param &block - Block to be executed by the form builder
  def collect_info(values={}, &block)
    form = FormBuilder.new(values)
    form.collect(&block)
  end
  
  private

  def with_fzf_filter(multiple: false)
    command = "fzf"
    if multiple
      command += " -m" 
      print_info("Use <TAB> to select your choice")
    end

    io = IO.popen(command, 'r+')
    begin
      stdout = $stdout
      $stdout = io
      begin
        yield
      rescue StandardError
        nil
      end
    ensure
      $stdout = stdout
    end
    io.close_write
    io.readlines.map(&:chomp)
  end
end
