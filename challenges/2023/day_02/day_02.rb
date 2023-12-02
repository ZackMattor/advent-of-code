class Day02 < Day
  def pt1
    possible_game_ids = []

    loaded_with = {
      "red" => 12,
      "green" => 13,
      "blue" => 14
    }

    @raw_data.lines.each_with_index do |line, index|
      is_possible_game = parse_line(line).all? do |set|
        set.all? do |color, number|
          loaded_with[color] >= number
        end
      end

      possible_game_ids.push(index+1) if is_possible_game
    end

    possible_game_ids.sum
  end

  def pt2
    game_powers = @raw_data.lines.map do |line|
      required_load = { "red" => 0, "green" => 0, "blue" => 0 }

      # Loop through each game's set and figure out
      # what the minim required loading is per game
      parse_line(line).each do |color_data|
        color_data.each do |color, number|
          required_load[color] = number if required_load[color] < number
        end
      end

      # Return the power of the given game
      required_load.values.inject(:*)
    end

    # The answer is the sum of all of the 
    # game's powers
    game_powers.sum
  end

  private

  def parse_line(line)
    line_parts = line.split(":").last.split(";")

    game_data = line_parts.map do |raw_set|
      raw_set.split(",").map do |set_parts|
        parts = set_parts.split

        [parts.last, parts.first.to_i]
      end.to_h
    end

    game_data
  end
end
