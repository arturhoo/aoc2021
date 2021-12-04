# frozen_string_literal: true

# https://adventofcode.com/2021/day/4
class D4
  def initialize(input)
    @boards = []
    parse_input(input)
  end

  def p1
    winner_board, num = draw
    unmarked_sum = winner_board.sum_unmarked
    unmarked_sum * num
  end

  def p2; end

  private

  def draw
    @drawn_numbers.each do |num|
      @boards.each do |board|
        return board, num if board.mark_drawn(num) == :bingo
      end
    end
  end

  def parse_input(input)
    lines = input.split("\n")
    @drawn_numbers = lines[0].split(',').map(&:to_i)
    parse_boards(lines[2..])
  end

  def parse_boards(lines)
    temp_lines = []
    lines.each do |line|
      if line.empty?
        @boards << Board.new(temp_lines)
        temp_lines = []
      else
        temp_lines << line
      end
    end
    @boards << Board.new(temp_lines) unless temp_lines.empty?
  end
end

# Bingo board
class Board
  # @param lines [Array<String>] list of string of numbers
  def initialize(lines)
    @numbers = []
    lines.each { |l| @numbers << l.split.map(&:to_i) }

    @rows_cnt = @numbers.length
    @cols_cnt = @numbers[0].length
    @score = {
      rows: Array.new(@rows_cnt) { 0 },
      cols: Array.new(@cols_cnt) { 0 }
    }
    @markings = Array.new(@rows_cnt) { Array.new(@cols_cnt) { false } }
    @bingo = false
  end

  def mark_drawn(drawn_number)
    @numbers.each_with_index do |row, r_idx|
      next unless row.include?(drawn_number)

      c_idx = row.index drawn_number
      @markings[r_idx][c_idx] = true
      @score[:rows][r_idx] += 1
      @score[:cols][c_idx] += 1

      @bingo = true if @score[:rows][r_idx] == @cols_cnt
      @bingo = true if @score[:cols][c_idx] == @rows_cnt
      break
    end
    return :bingo if @bingo
  end

  def sum_unmarked
    sum = 0
    @numbers.each_with_index do |row, r_idx|
      row.each_with_index do |num, c_idx|
        sum += num unless @markings[r_idx][c_idx]
      end
    end
    sum
  end

  def print
    puts(@numbers.to_s)
  end
end

if $PROGRAM_NAME == __FILE__
  file = File.read('input4.txt')

  puts(D4.new(file).p1)
  puts(D4.new(file).p2)
end
