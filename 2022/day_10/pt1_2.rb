require './cpu.rb'
require './crt_screen.rb'

def pt1(input_file)
  score = 0
  cpu = Cpu.new
  cpu.import_program_file(input_file)

  debugger = Proc.new { |state|
    score += state['tick'] * state['registers']['x']
  }

  [20, 60, 100, 140, 180, 220].each do |tick|
    cpu.add_breakpoint(tick, &debugger)
  end

  cpu.exec!# debug: true

  puts "Answer for Pt1 for #{input_file}: #{score}"
end


def pt2(input_file)
  score = 0

  crt_screen = CrtScreen.new

  cpu = Cpu.new
  cpu.import_program_file(input_file)
  cpu.connect_device(crt_screen)

  cpu.exec!

  puts "Answer for Pt1 for #{input_file}"
  crt_screen.render
end

pt1("sample.txt")
pt1("input.txt")
puts
pt2("sample.txt")
pt2("input.txt")
