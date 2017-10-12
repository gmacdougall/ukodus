class Sudoku
  def initialize(puzzle)
    @puzzle = puzzle.gsub(/[^\d]/, '').split('')
  end

  def rows
    @puzzle.each_slice(9).map { |n| n }
  end

  def columns
    result = Array.new(9) { [] }
    @puzzle.each_with_index { |n, idx| result[idx % 9].push(n)  }
    result
  end

  def boxes
    result = Array.new(9) { [] }
    @puzzle.each_with_index do |n, idx|
      box_idx = ((idx / 27) * 3) + ((idx % 9) / 3)
      result[box_idx].push(n)
    end
    result
  end

  def to_s
    @puzzle.each_slice(9).map { |n| n.join(' ') }.join("\n")
  end
end
