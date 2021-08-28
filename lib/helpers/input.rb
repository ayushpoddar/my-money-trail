require_relative "printer"

module Input
  include Printer

  # Select an option out of multiple possibilities
  # @param possibilities [Array<String>]
  # @param multiple [Boolean] if you want multiple selections possible
  # @return [Array<String>]
  def select_option(possibilities, multiple: false)
    with_fzf_filter(multiple: multiple) do
      puts possibilities
    end
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
