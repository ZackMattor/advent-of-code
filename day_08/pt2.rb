require "awesome_print"

segments = File.read('input.txt').lines.map { |l| l.split("|").map { |s| s.split(" ")}}
known = { 2 => [1], 4 => [4], 3 => [7], 7 => [8], 5 => [2,3,5], 6 => [6,9,0]}
sum = 0

def assert_segment_diffs(a,b,diffs=0)
  (a & b).length
end

segments.each do |in_data,out_data|
  # If the length of a data segment matches a 
  # key here, that means we sort of know what number
  # it could be trying to outup
  answers = { 0 => [], 1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => [], 8 => [], 9 => [] }

  in_data.each do |raw_number|
    possible_answers = known[raw_number.length]

    possible_answers.each do |num|
      answers[num].push raw_number.chars.sort
    end
  end

  ## Attempt some strategies
  answers[3] = answers[3].select { |x| assert_segment_diffs(x, answers[1].first) == 2 }
  answers[2] = answers[2].reject { |x| x == answers[3].first }

  answers[9] = answers[9].select { |x| (x & answers[3].first).length == 5 }
  answers[0] = answers[0].reject { |x| x == answers[9].first }
  answers[6] = answers[6].reject { |x| x == answers[9].first }

  answers[0] = answers[0].select { |x| (x & answers[7].first).length == 3 }
  answers[6] = answers[6].reject { |x| x == answers[0].first }

  answers[5] = answers[5].select { |x| (x & answers[6].first).length == 5 }
  answers[2] = answers[2].reject { |x| x == answers[5].first }

  answer_mapping = answers.map { |k,v| [v[0].join, k]}.to_h
  clean_out_data = out_data.map { |a| a.chars.sort.join}
  ans = clean_out_data.map { |a| answer_mapping[a]}.join.to_i
  sum += ans
end

puts sum
