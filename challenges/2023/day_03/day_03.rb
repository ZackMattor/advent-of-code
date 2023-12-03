class Day02 < Day
  def pt1
    ans = 0

    @raw_lines.each_with_index do |line, y_loc|
      number_parts = []
      sees_symbol = false

      line.chars.each_with_index do |char, x_loc|
        was_num = false

        if char.match /\d/
          was_num = true
          number_parts.push(char)

          # Check to see if this number
          # observes a symbol
          sees_symbol = sees_symbol || [
            [1,0], [-1,0], [0,1], [0,-1],
            [1,1], [-1,1], [1,-1], [-1,-1],
          ].any? do |vx, vy|
            x = x_loc + vx
            y = y_loc + vy

            next false if x < 0 || y < 0
            next false if @raw_lines[y]&.chars&.dig(x).nil?
            next @raw_lines[y][x].match /[^\d\.\n]/
          end
        end


        # If this is the end of a number segment
        # we should process the item.
        if (!was_num || x_loc == line.length-1) && !number_parts.empty?
          if sees_symbol
            print(number_parts.join.colorize(:yellow))
            ans = ans + number_parts.join.to_i
          else
            print(number_parts.join.colorize(:white))
          end

          number_parts = []
          sees_symbol = false
        end

        print(char) unless char.match /\d/
      end

    end

    ans
  end

  def pt2
    nil
  end
end
