require 'awesome_print'

height_map = File.read('input.txt').lines.map { |l| l.strip.chars.map(&:to_i) }

def surrounding_values(map, x, y)
  ar = []
  ar << (map.dig(y+1, x))
  ar << (map.dig(y-1, x)) if y != 0
  ar << (map.dig(y, x-1)) if x != 0
  ar << (map.dig(y, x+1))
  ar.compact
end

def crawl_basin(map, x, y, points=[],last_val=nil)
  val = map[y]&.dig(x)
  val_valid = !val.nil? && val != 9

  if val_valid && (last_val.nil? || last_val < val)
    points.push([x,y])
    points = crawl_basin(map,x+1,y,points, val)
    points = crawl_basin(map,x-1,y,points, val) if x != 0
    points = crawl_basin(map,x,y+1,points, val)
    points = crawl_basin(map,x,y-1,points, val) if y != 0
  end

  points
end

basin_sizes = []

height_map.each_with_index do |row, y|
  row.each_with_index do |height, x|
    is_low = surrounding_values(height_map,x,y).all? { |val| height < val }

    if is_low
      basin_sizes << crawl_basin(height_map,x,y).uniq.count
    end
  end
end

p "Answer: #{basin_sizes.sort.last(3).inject(&:*)}"
