height_map = File.read('input.txt').lines.map { |l| l.strip.chars.map(&:to_i) }

lows = []

def surrounding_values(map, x, y)
  [(map[y+1]&.dig(x)),
   (map[y-1]&.dig(x)),
   (map[y]&.dig(x-1)),
   (map[y]&.dig(x+1))].compact
end

height_map.each_with_index do |row, y|
  row.each_with_index do |height, x|
    is_low = surrounding_values(height_map,x,y).all? { |val| height < val }

    lows.push(height) if is_low
  end
end

p "Answer: #{lows.inject { |s, v| s += (v)+1 } + 1}"
