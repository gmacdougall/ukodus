class Solver
  def initialize(sudoku)
    @sudoku = sudoku
  end

  def solveable?
    solveable = true
    @sudoku.puzzle.each_with_index do |n, idx|
      col = idx % 9
      row = idx / 9

      if (n == ' ')
        solveable = false unless (
          @sudoku.rows[row] +
          @sudoku.columns[col] +
          @sudoku.boxes[@sudoku.box_index(row, col)]
        ).uniq.length === 9
      end
    end
    solveable
  end
end
