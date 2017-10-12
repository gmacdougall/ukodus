class Solver
  def initialize(sudoku)
    @sudoku = sudoku
  end

  def solveable?
    previous_iteration = nil
    iteration = @sudoku
    while (previous_iteration.nil? || iteration.score != previous_iteration.score) do
      previous_iteration = iteration
      iteration.puzzle.each_with_index do |n, idx|
        col = idx % 9
        row = idx / 9

        if (single_candidate(row, col))
          new_puzzle = iteration.puzzle.dup
          new_puzzle[idx] = single_candidate(row, col)
          iteration = Sudoku.new(new_puzzle)
        end
      end
    end
    iteration.score === 0
  end

  private

  def single_candidate(row, col)
    if @sudoku.candidates(row, col).length === 8
      ((1..9).to_a - @sudoku.candidates(row, col)).first
    else
      nil
    end
  end
end
