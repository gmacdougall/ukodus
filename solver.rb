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

  def hard_solveable?
    attempt = @sudoku
    empty_pos = attempt.empty.first

    candidates = attempt.candidates(empty_pos / 9, empty_pos % 9)
    ((1..9).to_a - candidates).flat_map do |candidate|
      new_puzzle = @sudoku.puzzle.dup
      new_puzzle[empty_pos] = candidate

      new_sudoku = Sudoku.new(new_puzzle)

      if new_sudoku.broken?
        false
      elsif new_sudoku.complete?
        true
      else
        Solver.new(new_sudoku).hard_solveable?
      end
    end.select { |y| y }.count == 1
  end

  private

  def single_candidate(attempt, row, col)
    if attempt.candidates(row, col).length === 8
      result = ((1..9).to_a - attempt.candidates(row, col))
      result.first
    else
      nil
    end
  end
end
