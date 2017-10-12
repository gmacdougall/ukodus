class Sudoku
  attr_reader :puzzle

  def initialize(puzzle)
    @puzzle = puzzle
  end

  def [](row, column)
    @puzzle[row * 9 + column]
  end

  def box_index(row, column)
    ((row / 3) * 3) + (column / 3)
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
      result[box_index(idx / 9, idx % 9)].push(n)
    end
    result
  end

  def to_s
    result = []
    result << "+-------+-------+-------+"
    rows.each_with_index do |row, idx|
      result << '| ' + row.each_slice(3).map { |a| a.join(' ') }.join(' | ') + ' |'
      result << "+-------+-------+-------+" if idx == 2 || idx == 5
    end
    result << "+-------+-------+-------+"
    result.join("\n")
  end

  def solveable?
    solveable = true
    @puzzle.each_with_index do |n, idx|
      col = idx % 9
      row = idx / 9

      if (n == ' ')
        solveable = false unless
          (rows[row] + columns[col] + boxes[box_index(row, col)]).uniq.length === 9
      end
    end
    solveable
  end

  def score
    81 - @puzzle.reject { |s| s === ' ' }.count
  end
end
