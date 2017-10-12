class Solver
  def initialize(sudoku)
    @sudoku = sudoku
  end

  def solveable?
    attempt = @sudoku
    previous_score = -1
    while (attempt.incomplete? && attempt.score != previous_score)
      attempt.puzzle.each_with_index do |n, idx|
        if (n === ' ')
          if single_candidate(attempt, idx / 9, idx % 9)
            new_puzzle = attempt.puzzle.dup
            new_puzzle[idx] = single_candidate(attempt, idx / 9, idx % 9)
            attempt = Sudoku.new(new_puzzle)
          end
        end
      end
      previous_score = attempt.score
    end
    attempt.complete?
  end

  private

  def single_candidate(attempt, row, col)
    if attempt.candidates(row, col).length === 8
      result = ((1..9).map(&:to_s).to_a - attempt.candidates(row, col))
      result.first
    else
      nil
    end
  end
end
