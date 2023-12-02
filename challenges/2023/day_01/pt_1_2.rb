def day_01_pt1(input_file)
  lines = File.read(input_file).lines

  line_nums = lines.map do |line|
    nums = line.chars.select { |c| c.match? /\d/ }

    "#{nums.first}#{nums.last}".to_i
  end

  puts "Answer for input #{input_file} for Day1 Pt1 : #{ line_nums.sum }"
end


def day_01_pt2(input_file)
  def check_segment(segment)
    return segment[0] if segment.match? /^\d/

    { "one" => "1",
      "two" => "2",
      "three" => "3",
      "four" => "4",
      "five" => "5",
      "six" => "6",
      "seven" => "7",
      "eight" => "8",
      "nine" => "9"
    }.each do |k, v|
      return v if segment.match? /^#{k}/
    end

    nil
  end

  lines = File.read(input_file).lines

  ans = lines.sum do |line|
    first = nil
    last = nil

    line.length.times do |i|
      first = check_segment(line[i..-1]) if first.nil?
      last = check_segment(line[-(i+1)..-1]) if last.nil?

      break if first && last
    end

    puts "#{first}#{last}"
    "#{first}#{last}".to_i
  end

  puts "Answer for input #{input_file} for Day1 Pt1 : #{ ans }"
end

#day_01_pt1("sample.txt")
#day_01_pt1("input.txt")
#puts
#day_01_pt2("sample_p2.txt")
#day_01_pt2("input2.txt")
day_01_pt2("input.txt")
