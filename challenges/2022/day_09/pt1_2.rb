require 'awesome_print'
require 'io/console'
require 'pry'

DIR_TO_VEC = {
  'U' => [1, 0],
  'D' => [-1, 0],
  'L' => [0, -1],
  'R' => [0, 1],
}

def render(points, w=10, h=10)
  map = Array.new(h).map { Array.new(w, '*') }

  points.each do |p|
    map[p[0]][p[1]] = "#"
  end

  map.reverse.each do |row|
    puts row.join
  end
  puts
end

def vec_op(a,b, op=:+)
  a.zip(b).map { |x| x.reduce(op) }
end

def parse(input_file)
  data = File.readlines(input_file, chomp: true)

  data.map do |raw_cmd|
    matched = raw_cmd.match /^([UDLR]) (\d*)/

    [
      DIR_TO_VEC[matched[1]],
      matched[2].to_i # Number of moves
    ]
  end
end

def move_tail(tail, taildif)
  y = taildif[0]
  x = taildif[1]

  x = x.abs != x ? -1 : 1 if x != 0
  y = y.abs != y ? -1 : 1 if y != 0

  vec_op(tail, [y,x])
end

def pt1(input_file)
  move_commands = parse(input_file)
  places = []
  head = [0, 0]
  tail = [0, 0]
  places.push tail

  move_commands.each do |vec, num|
    num.times do
      head = vec_op(head, vec, :+)
      tail_dif = vec_op(head, tail, :-)

      # Determine if the tail is lagging
      if tail_dif[0].abs > 1 || tail_dif[1].abs > 1
        tail = move_tail(tail, tail_dif)
        places.push tail
      end
    end
    #render([ head, tail ])
  end

  puts "Answer for Pt1 : #{places.uniq.length}"
end


def pt2(input_file)
  num_tails = 9

  move_commands = parse(input_file)
  places = []
  head = [0, 0]
  tails = Array.new(num_tails).map { [0, 0] }
  places.push tails[8]

  move_commands.each do |vec, num|
    num.times do
      head = vec_op(head, vec, :+)

      tails.each_with_index do |tail, index|
        prev_item = index > 0 ? tails[index-1] : head
        tail_dif = vec_op(prev_item, tails[index], :-)

        # Determine if the tail is lagging
        if tail_dif[0].abs > 1 || tail_dif[1].abs > 1
          tails[index] = move_tail(tails[index], tail_dif)
          places.push tails[index] if index == tails.length-1
        end

        #render([ head ].concat(tails))
      end
    end
  end

  puts "Answer for Pt2 : #{places.uniq.length}"
end

pt1("sample.txt")
pt1("input.txt")
puts
pt2("sample2.txt")
pt2("input.txt")
