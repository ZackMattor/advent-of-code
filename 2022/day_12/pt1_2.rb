require 'pry'
require 'awesome_print'

class Graph
  attr_accessor :locations, :destination_node, :start_node, :all_nodes

  def reset!
    @all_nodes.each &:reset!
  end

  def search!
    reset!
    start_node.distance = 0

    current_node = start_node
    unvisited_nodes = []

    loop do
      current_node.neighbors.each do |neighbor|
        next if neighbor.visited

        unvisited_nodes << neighbor
        new_distance = current_node.distance + 1
        neighbor.distance = new_distance if neighbor.distance > new_distance
      end

      unvisited_nodes.reject! { |node| node == current_node }
      current_node.visited = true
      current_node = unvisited_nodes.sort_by { |node| node.distance }.first

      break if current_node.nil? || destination_node.visited
    end

    destination_node.distance
  end

  def self.import_locations(input_file)
    raw_map = File.readlines(input_file, chomp: true).map &:chars
    location_map = []
    lowest_lows = []
    all_nodes = []
    root_location = nil
    end_location = nil

    # Create unlinked location
    raw_map.each_with_index do |row, y|
      location_map[y] = []

      row.each_with_index do |location, x|
        loc = Location.new

        loc.height = case location
                     when 'S'
                       root_location = loc
                       0
                     when 'E'
                       end_location = loc
                       25
                     else
                       location.ord - 97
                     end

        lowest_lows << loc if loc.height == 0
        loc.id = "#{x},#{y}"
        all_nodes << loc
        location_map[y] << loc
      end
    end

    # Wire up graph
    location_map.each_with_index do |row, y|
      row.each_with_index do |location, x|
        [[0,1],[0,-1],[-1,0],[1,0]].each do |vx, vy|
          neighbor = location_map.dig(y+vy, x+vx)
          next if neighbor.nil? || y+vy < 0 || x+vx < 0

          location.neighbors << neighbor if location.height >= neighbor.height-1
        end
      end
    end

    graph = new
    graph.destination_node = end_location
    graph.start_node = root_location
    graph.all_nodes = all_nodes
    graph
  end
end

class Location
  attr_accessor :neighbors, :height, :id, :distance, :visited

  def initialize
    @neighbors = []
    reset!
  end

  def reset!
    @distance = Float::INFINITY
    @visited = false
  end
end

def pt1(input_file)
  graph = Graph.import_locations(input_file)

  graph.search!

  puts "Steps required for #{input_file}: #{graph.destination_node.distance}"
end


def pt2(input_file)
  graph = Graph.import_locations(input_file)

  starting_points = graph.all_nodes.select { |node| node.height == 0 }

  items = starting_points.map do |start|
    graph.start_node = start
    graph.search!
  end

  puts "Steps required for #{input_file}: #{items.sort.first}"
end

pt1("sample.txt")
pt1("input.txt")
puts
pt2("sample.txt")
pt2("input.txt")
