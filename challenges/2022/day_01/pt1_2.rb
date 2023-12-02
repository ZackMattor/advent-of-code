def day_01(input_file)
  index = 0
  res = []

  File.read(input_file).lines.each do |item|
    if item.strip.empty?
      index+=1
    else
      res[index] ||= 0
      res[index] += item.to_i
    end
  end

  puts "Results for #{input_file}"
  puts "Pt1: #{res.max}"
  puts "Pt2: #{res.sort[-3..-1].sum}"
end

day_01("sample.txt")
puts
day_01("input.txt")
