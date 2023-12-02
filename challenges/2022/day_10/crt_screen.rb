class CrtScreen
  def initialize
    @buffer = []
  end

  def tick!(cpu_state)
    tick = ( cpu_state['tick'] - 1) % 40
    sprite_pos = cpu_state['registers']['x']

    is_lit = tick >= sprite_pos-1 && tick <= sprite_pos+1
    @buffer.push is_lit
  end

  def render
    @buffer.each_slice(40).to_a.each do |row|
      puts row.map { |pixel| pixel ? '#' : '.' }.join
    end
  end
end
