class Cpu
  def initialize
    # Program Management
    @cursor = 0
    @program = []

    # CPU
    @tick = 0
    @breakpoints = {}
    @connected_devices = []
    @registers = {
      'x' => 1
    }
  end

  def import_program_file(input_file)
    @program = File.readlines(input_file, chomp: true).map &:split
  end

  def connect_device(device)
    @connected_devices << device
  end

  def add_breakpoint(tick, &block)
    @breakpoints[tick] = block
  end

  def exec!(debug: false)
    loop do
      step!
      state = read_state
      puts state if debug
      break if state['program_end']
    end
  end

  def step!
    unless program_end?
      cmd = @program[@cursor]
      send(*cmd)
      @cursor += 1
    end
  end

  def read_state
    {
      'cursor' => @cursor,
      'tick' => @tick,
      'program_end' => program_end?,
      'registers' => @registers,
    }
  end

  private

  def program_end?
    @cursor >= @program.length
  end

  def tick!
    @tick += 1

    @connected_devices.each { |cd| cd.tick!(read_state) }
    @breakpoints[@tick]&.call(read_state)
  end

  def noop
    tick!
  end

  def addx(num)
    tick!
    tick!

    @registers['x'] += num.to_i
  end
end
