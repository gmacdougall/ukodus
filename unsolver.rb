class Unsolver
  def initialize(sudoku)
    @sudoku = sudoku
  end

  def go
    attempt = @sudoku
    81.times do |n|
      proposed_arr = attempt.puzzle.dup
      proposed_arr[n] = ' '
      proposed = Sudoku.new(proposed_arr)
      if Solver.new(proposed).hard_solveable?
        attempt = proposed
        puts attempt.to_s
      end
    end
    attempt
  end
end
