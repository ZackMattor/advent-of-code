require 'awesome_print'
require 'pry'

def parse(input_file)
  lines = File.readlines(input_file, chomp: true).reverse

  files = { "/" => {}}
  path = []

  until lines.empty? do
    cmd, arg = lines.pop.match(/^\$ (.*)/)[1].split

    case cmd
    when 'ls'
      while ( !lines.last.nil? && !lines.last.start_with?("$") ) do
        file = lines.pop
        size, name = file.split
        files.dig(*path)[name] = size == 'dir' ? {} : size.to_i
      end
    when 'cd'
      if arg == '..'
        path.pop
      else
        path.push arg
      end
    end
  end

  files
end

def craw_folders(files, folder_sizes=[])
  files.to_a.sum do |name, value|
    if value.is_a? Hash
      size = craw_folders(value, folder_sizes)
      folder_sizes << size
      size
    else
      value
    end
  end
end

def pt1(input_file)
  files = parse(input_file)
  folder_sizes = []

  craw_folders(files, folder_sizes)
  ans = folder_sizes.filter do |i|
    i <= 100_000
  end.sum

  puts "Answer for Pt1 #{input_file}: #{ans}"
end


def pt2(input_file)
  space_required = 30000000
  files = parse(input_file)
  folder_sizes = []

  total_consumed = craw_folders(files, folder_sizes)
  space_free = 70000000 - total_consumed
  ans = folder_sizes.sort.find do |size|
    (space_free + size) >= 30000000
  end

  puts "Answer for Pt2 #{input_file}: #{ans}"
end

pt1("sample.txt")
pt1("input.txt")
puts
pt2("sample.txt")
pt2("input.txt")
