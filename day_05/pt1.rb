raw = File.read('input.txt')
size=1100
map = (1..size).map { |_| (1..size).map{ |_| 0} }
parts = raw.lines.map { |l| l.split('->').map {|a| a.split(',').map(&:to_i)}}
count = 0

def range(a,b)
  if a <= b
    (a..b).to_a
  else
    a.downto(b).to_a
  end
end

#
# Process all line pairs
parts.each do |pair|
  x1 = pair[0][0]
  y1 = pair[0][1]
  x2 = pair[1][0]
  y2 = pair[1][1]

  if(x1 == x2) # Vertical
    #puts "vert (#{x1},#{y1}) (#{x2},#{y2})"
    range(y1,y2).each { |y| map[y][x1] += 1 }
  elsif(y1 == y2) # Horizontal
    #puts "horiz (#{x1},#{y1}) (#{x2},#{y2})"
    range(x1,x2).each { |x| map[y1][x] += 1 }
  else
    #puts "wacky (#{x1},#{y1}) (#{x2},#{y2})"
    xr = range(x1,x2)
    yr = range(y1,y2)

    xr.each_with_index { |x, i| map[yr[i]][x] += 1 }
  end
end

count = 0
map.each do |row|
  row.each do |col|
    if col >= 2
      count+=1 
    end
    #print col
  end
  #print "\n"
end

puts "Total points that intersect twice or more... #{ count }"
