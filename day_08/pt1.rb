require "awesome_print"

out_segments = File.read('input.txt').lines.map {|l| l.split("|").map { |s| s.split(" ")}.last }.flatten

ap out_segments.filter { |s| [2,4,3,7].include?(s.length) }.count
