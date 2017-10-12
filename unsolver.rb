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
      attempt = proposed if Solver.new(proposed).solveable?
    end
    attempt
  end
end
