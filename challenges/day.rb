class Day
  def initialize(year, day, input_file)
    @raw_data = File.read("./challenges/#{year}/#{day}/#{input_file}")
    @raw_lines = @raw_data.lines
  end
end
