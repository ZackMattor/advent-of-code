require 'pry'
require 'awesome_print'

Point = Struct.new(:x, :y) do
  def to_a
    [y, x]
  end
end

Sensor = Struct.new(:point, :radius) do
  def sees_point?(p)
    taxi_distance(point, p) <= radius
  end
end

def taxi_distance(a, b)
  (a.x - b.x).abs + (a.y - b.y).abs
end

class BeaconMap
  attr_accessor :map, :sensors, :beacons

  def initialize
    @beacons = []
    @sensors = []
    @map = {}
  end

  def read_sensor_readings_from_file!(input_file)
    raw_readings = File.readlines(input_file, chomp: true)

    parse_regex = /Sensor at x=([-]?\d+), y=([-]?\d+): closest beacon is at x=([-]?\d+), y=([-]?\d+)/

    raw_readings.each do |raw_reading|
      md = raw_reading.match(parse_regex)

      sensor_loc = Point.new(md[1].to_i, md[2].to_i)
      beacon_loc = Point.new(md[3].to_i, md[4].to_i)

      read_sensor!(sensor_loc, beacon_loc)
    end
  end

  def read_sensor!(sensor_loc, closest_beacon_loc)
    radius = taxi_distance(sensor_loc, closest_beacon_loc)

    @sensors << Sensor.new(sensor_loc, radius)
    @beacons << closest_beacon_loc

    insert_item!(sensor_loc, 'S')
    insert_item!(closest_beacon_loc, 'B')
  end

  def insert_item!(point,item)
    @map[point.y] = {} if @map[point.y].nil?
    @map[point.y][point.x] = item
  end


  def get_map_bounds
    x_min = Float::INFINITY
    x_max = -Float::INFINITY

    y_min = Float::INFINITY
    y_max = -Float::INFINITY

    @sensors.each do |sensor|
      x_val = sensor.point.x - sensor.radius
      x_min = x_val if x_min > x_val

      x_val = sensor.point.x + sensor.radius
      x_max = x_val if x_max < x_val

      y_val = sensor.point.y - sensor.radius
      y_min = y_val if y_min > y_val

      y_val = sensor.point.y + sensor.radius
      y_max = y_val if y_max < y_val
    end

    [
      (y_min..y_max),
      (x_min..x_max)
    ]
  end

  def sensor_ranges_on_row(y)
    raw_ranges = @sensors.map do |s|
      distance = ( y - s.point.y ).abs
      next nil if s.radius < distance

      length = ( s.radius - distance)

      (( s.point.x - length ) .. ( s.point.x + length ))
    end.compact

    combined = nil
    previous_count = raw_ranges.length
    loop do
      raw_ranges = combined if raw_ranges.empty?
      combined = [raw_ranges.pop]

      while range = raw_ranges.pop
        items = combined.each_with_index.map do |r, i|
          if r.cover?(range.first) || range.cover?(r.first)
            combined[i] = Range.new(
              [range.first, r.first].min,
              [range.end, r.end].max,
            )
            nil
          else
            range
          end
        end.compact.uniq

        combined.concat(items).uniq!
      end

      break if previous_count == combined.length

      previous_count = combined.length
    end

    combined
  end
end

def pt1(input_file)
  bm = BeaconMap.new
  bm.read_sensor_readings_from_file!(input_file)
  row = input_file == 'sample.txt' ? 10 : 2000000

  ranges = bm.sensor_ranges_on_row(row)
  visible_count = ranges.map(&:count).sum

  beacons_on_row = bm.beacons.uniq.count do |point|
    point.y == row
  end

  puts "Steps required for #{input_file}: #{visible_count - beacons_on_row}"
end


def pt2(input_file)
  limit = input_file == 'sample.txt' ? 20 : 4000000
  bm = BeaconMap.new
  bm.read_sensor_readings_from_file!(input_file)

  ans = nil
  (limit).downto(1).any? do |y|
    ranges = bm.sensor_ranges_on_row(y)
    ranges = ranges.sort_by { |x| x.first }

    if ranges.count == 2 && ranges[0].last + 1 != ranges[1].first
      puts y
      puts ranges
      ans = 4000000 * (ranges[0].last + 1) + y
    end
  end

  puts "Steps required for #{input_file}: #{ans}"
end

pt1("sample.txt")
pt1("input.txt")
puts
pt2("sample.txt")
pt2("input.txt")
