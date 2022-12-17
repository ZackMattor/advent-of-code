require 'pry'
require 'awesome_print'

Point = Struct.new(:x, :y)
Sensor = Struct.new(:point, :radius)

def taxi_distance(a, b)
  (a.x - b.x).abs + (a.y - b.y).abs
end

class BeaconMap
  attr_accessor :map, :sensors, :beacons

  def initialize
    @beacons = []
    @sensors = []
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
