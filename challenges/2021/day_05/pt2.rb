raw = File.read('input.txt')
size=999
$map = (1..size).map { |_| (1..size).map{ |_| 0} }
point_pairs = raw.lines.map { |l| l.split('->').map {|a| a.split(',').map(&:to_i)}}
$count = 0

def range(a,b)
  if a <= b
    (a..b).to_a
  else
    a.downto(b).to_a
  end
end

def incr(x,y)
  $count += 1 if 2 == ( $map[y][x] += 1 )
end

point_pairs.each do |pair|
  ((x1,y1),(x2,y2)) = pair

  if(x1 == x2) # Vertical
    #puts "vert (#{x1},#{y1}) (#{x2},#{y2})"
    range(y1,y2).each { |y| incr(x1,y) }
  elsif(y1 == y2) # Horizontal
    #puts "horiz (#{x1},#{y1}) (#{x2},#{y2})"
    range(x1,x2).each { |x| incr(x,y1) }
  else
    #puts "wacky (#{x1},#{y1}) (#{x2},#{y2})"
    xr = range(x1,x2)
    yr = range(y1,y2)

    xr.each_with_index { |x, i| incr(x,yr[i]) }
  end
end

puts "Total points that intersect twice or more... #{ $count }"
