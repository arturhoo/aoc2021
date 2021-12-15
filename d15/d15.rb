# frozen_string_literal: true

require 'set'

# https://adventofcode.com/2021/day/12
class D15
  def initialize(input)
    parse_input(input)
  end

  def p1
    path = [[0, 0]]
    find_path(path)
    @best_path_cost
  end

  def p2
    :ok
  end

  private

  def parse_input(input)
    @grid = input.split("\n").map { |l| l.chars.map(&:to_i) }
    @width = @grid[0].length
    @height = @grid.length
  end

  def find_path(current_path)
    last_pos = current_path[-1]
    current_path_cost = path_cost(current_path)
    if last_pos[0] == @height - 1 && last_pos[1] == @width - 1 && (@best_path.nil? || current_path_cost < @best_path_cost)
      @best_path = current_path
      @best_path_cost = current_path_cost
      return
    end

    possible_neigh(last_pos).each do |neigh|
      unless @best_path_cost && current_path_cost + @grid[neigh[0]][neigh[1]] > @best_path_cost
        find_path(current_path.dup << neigh)
      end
    end
  end

  def path_cost(path)
    sum = 0
    path[1..].each do |pos|
      sum += @grid[pos[0]][pos[1]]
    end
    sum
  end

  def possible_neigh(pos)
    possible_neigh = []
    possible_neigh << [pos[0] + 1, pos[1]] unless pos[0] == @height - 1
    possible_neigh << [pos[0], pos[1] + 1] unless pos[1] == @width - 1
    possible_neigh
  end
end

class Point
  attr_accessor :x, :y
end

if $PROGRAM_NAME == __FILE__
  file = File.read('input15.txt')

  puts(D15.new(file).p1)
  # puts(D15.new(file).p2)
end
