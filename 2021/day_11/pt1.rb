require 'awesome_print'

energy_map = File.read('input.txt').lines.map { |l| l.strip.chars.map(&:to_i) }

def increment_surrounding(map,x,y, flashes)
  ( map, flashes ) = increment_point(map,x+1,y, flashes)
  ( map, flashes ) = increment_point(map,x-1,y, flashes) if x != 0
  ( map, flashes ) = increment_point(map,x,y+1, flashes)
  ( map, flashes ) = increment_point(map,x,y-1, flashes) if y != 0

  ( map, flashes ) = increment_point(map,x+1,y+1, flashes)
  ( map, flashes ) = increment_point(map,x+1,y-1, flashes) if y != 0
  ( map, flashes ) = increment_point(map,x-1,y+1, flashes) if x != 0
  ( map, flashes ) = increment_point(map,x-1,y-1, flashes) if x != 0 && y != 0

  [map, flashes]
end

def increment_point(map,x,y, flashes)
  if map.dig(y, x)
    if map[y][x] >= 9
      flashes += 1
      map[y][x] = 0
      (map, flashes) = increment_surrounding(map,x,y,flashes)
    else
      if map[y][x] != 0
        map[y][x] += 1
      end
    end
  end

  [map, flashes]
end

flashes = 0
100.times do |i|
  puts i
  energy_map.each_with_index do |row, y|
    row.each_with_index do |height, x|
      print energy_map[y][x]
      STDOUT.flush
    end
    print "\n"
  end

  energy_map.each_with_index do |row, y|
    row.each_with_index do |height, x|
      energy_map[y][x] += 1
    end
  end

  energy_map.each_with_index do |row, y|
    row.each_with_index do |height, x|
      if energy_map[y][x] > 9
        energy_map[y][x] = 0
        flashes += 1
        ( energy_map, flashes ) = increment_surrounding(energy_map,x,y, flashes)
      end
    end
  end

  print "\n"
end

puts flashes
