require 'pry'
require 'awesome_print'

class Cave
  attr_accessor :map, :active_sand, :settled_sand_count, :disable_render, :floor

  def initialize
    @map = {}
    @active_sand = []
    @settled_sand_count = 0
    @disable_render = false
    @floor = nil
  end

  def spawn_sand!
    spawn_point = [0, 500]

    @active_sand << spawn_point
  end

  def process_sand!
    @active_sand = @active_sand.map do |sand_loc|
      sand_y, sand_x = sand_loc

      is_active = [[ 1, 0 ], [ 1, -1 ], [1, 1]].any? do |vy, vx|
        x = sand_x + vx
        y = sand_y + vy

        if @floor && y == @floor
          next false
        end

        has_slot = !@map.dig(y, x)

        if has_slot
          sand_loc[0] = y
          sand_loc[1] = x
        end

        has_slot
      end

      unless is_active
        @settled_sand_count += 1
        insert_item!(sand_y, sand_x, 'o')
        nil
      else
        sand_loc
      end
    end.compact
  end

  def insert_item!(y,x,item)
    @map[y] = {} if @map[y].nil?
    @map[y][x] = item
  end

  def render
    return if @disable_render

    target = @active_sand.first
    return unless target

    if target
      y_range = (target[0]-10..target[0]+10)
      x_range = (target[1]-30..target[1]+30)
    end

    y_range.each do |y|
      x_range.each do |x|
        if @active_sand.include? [y,x]
          print "+"
          next
        end

        if @floor && @floor == y
          print "#"
          next
        end

        case @map.dig(y, x)
        when '#'
          print "#"
        when 'o'
          print "o"
        else
          print "."
        end
      end

      print "\n"
    end

    STDOUT.flush

    puts
  end

  def get_map_bounds
    x_min = Float::INFINITY
    x_max = 0

    @map.each do |y, row|
      x_vals = row.keys.sort

      x_min = x_vals.first if x_min > x_vals.first
      x_max = x_vals.last if x_max < x_vals.last
    end

    [
      (0..@map.keys.max),
      (x_min..x_max)
    ]
  end

  def add_line!(point_a, point_b)
    Range.new(*[point_a[1], point_b[1]].sort).each do |y|
      Range.new(*[point_a[0], point_b[0]].sort).each do |x|
        insert_item!(y, x, '#')
      end
    end
  end

  def import!(input_file)
    @map = {}
    lines = File.readlines(input_file, chomp: true)

    line_points = lines.map do |line|
      line.split(' -> ').map do |pair|
        pair.split(',').map &:to_i
      end
    end


    line_points.each do |line_pairs|
      line_pairs.each_with_index do |point_a, i|
        point_b = line_pairs[i+1]

        next if point_b.nil?

        add_line!(point_a, point_b)
      end
    end
  end
end

def pt1(input_file)
  cave = Cave.new
  cave.disable_render = true
  cave.import!(input_file)

  y_range, x_range = cave.get_map_bounds

  cave.render
  cave.spawn_sand!
  cave.render

  (1..).each do |c|
    active_sand = cave.process_sand!

    if active_sand.empty?
      cave.spawn_sand!
    else
      break if active_sand.first[0] > y_range.last
    end

    if c > 1
      cave.render
      sleep 0.1 unless cave.disable_render
    end
  end

  puts "Steps required for #{input_file}: #{cave.settled_sand_count}"
end


def pt2(input_file)
  cave = Cave.new
  cave.disable_render = true
  cave.import!(input_file)

  y_range, x_range = cave.get_map_bounds
  cave.floor = y_range.last + 2

  cave.render
  cave.spawn_sand!
  cave.render

  (1..).each do |c|
    active_sand = cave.process_sand!

    if active_sand.empty?
      break if cave.map.dig(0, 500) == 'o'
      cave.spawn_sand!
    end

    if c > 1
      cave.render
      sleep 0.1 unless cave.disable_render
    end 
  end

  puts "Steps required for #{input_file}: #{cave.settled_sand_count}"
end

pt1("sample.txt")
pt1("input.txt")
puts
pt2("sample.txt")
pt2("input.txt")
