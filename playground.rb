def with_filter(command)
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
