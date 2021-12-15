# frozen_string_literal: true

require 'set'

# https://adventofcode.com/2021/day/15
class D15
  def initialize(input)
    parse_input(input)
  end

  def p1
    a_star
    @costs[@height - 1][@width - 1]
  end

  def p2
    expand_grid
    a_star
    @costs[@height - 1][@width - 1]
  end

  private

  def parse_input(input)
    @grid = input.split("\n").map { |l| l.chars.map(&:to_i) }
    @width = @grid[0].length
    @height = @grid.length
  end

  def expand_grid
    @grid.each_with_index do |line, idx|
      4.times do
        line += line[-@width..].map { |i| increment_value(i) }
      end
      @grid[idx] = line
    end

    4.times do
      @grid[-@height..].each do |line|
        @grid << line.map { |i| increment_value(i) }
      end
    end
    @height *= 5
    @width *= 5
  end

  def setup_pathfinder
    @costs = Array.new(@height) { Array.new(@width) { Float::INFINITY } }
    @costs[0][0] = 0
    @h_costs = Array.new(@height) { Array.new(@width) { nil } }
    @h_costs[0][0] = 0
    # this should be a pqueue
    @pending = Set[[0, 0]]
  end

  def increment_value(val)
    new_val = val + 1
    return new_val unless new_val >= 10

    (new_val + 1) % 10
  end

  # https://www.redblobgames.com/pathfinding/a-star/introduction.html
  def a_star
    setup_pathfinder
    until @pending.empty?
      pos = pick_least_h_cost_pending_pos
      break if pos == [@height - 1, @width - 1]

      possible_neigh(pos).each { |neigh| process_neigh(pos, neigh) }
    end
  end

  def pick_least_h_cost_pending_pos
    pos = @pending.min_by { |p| @h_costs[p[0]][p[1]] }
    @pending.delete(pos)
    pos
  end

  def possible_neigh(pos)
    possible_neigh = []
    possible_neigh << [pos[0] + 1, pos[1]] unless pos[0] == @height - 1
    possible_neigh << [pos[0] - 1, pos[1]] unless pos[0].zero?
    possible_neigh << [pos[0], pos[1] + 1] unless pos[1] == @width - 1
    possible_neigh << [pos[0], pos[1] - 1] unless pos[1].zero?
    possible_neigh
  end

  def process_neigh(pos, neigh)
    tentative_cost = @costs[pos[0]][pos[1]] + @grid[neigh[0]][neigh[1]]
    return unless @costs[neigh[0]][neigh[1]] > tentative_cost

    @costs[neigh[0]][neigh[1]] = tentative_cost
    @h_costs[neigh[0]][neigh[1]] = tentative_cost + man_distance(neigh)
    @pending.add(neigh)
  end

  def man_distance(pos)
    @height - pos[0] + @width - pos[1]
  end
end

if $PROGRAM_NAME == __FILE__
  file = File.read('input15.txt')

  puts(D15.new(file).p1)
  puts(D15.new(file).p2)
end
