# frozen_string_literal: true

require 'set'

# https://adventofcode.com/2021/day/12
class D15
  def initialize(input)
    parse_input(input)
  end

  def p1
    @costs = Array.new(@height) { Array.new(@width) { Float::INFINITY } }
    @costs[0][0] = 0
    @visited = Set[]
    @unvisited = (0..@height - 1).map { |h| (0..@width - 1).map { |w| [h, w] } }.flatten(1).to_set
    dijkstra
    @costs[@height - 1][@width - 1]
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

  def dijkstra
    until @unvisited.empty?
      pos = pick_least_cost_pos
      @visited.add(pos)
      unvisited_neigh = possible_neigh(pos).to_set & @unvisited
      unvisited_neigh.each do |neigh|
        tentative_cost = @costs[pos[0]][pos[1]] + @grid[neigh[0]][neigh[1]]
        @costs[neigh[0]][neigh[1]] = tentative_cost if @costs[neigh[0]][neigh[1]] > tentative_cost
      end
    end
  end

  def possible_neigh(pos)
    possible_neigh = []
    possible_neigh << [pos[0] + 1, pos[1]] unless pos[0] == @height - 1
    possible_neigh << [pos[0] - 1, pos[1]] unless pos[0].zero?
    possible_neigh << [pos[0], pos[1] + 1] unless pos[1] == @width - 1
    possible_neigh << [pos[0], pos[1] - 1] unless pos[1].zero?
    possible_neigh
  end

  def pick_least_cost_pos
    pos = @unvisited.min_by { |p| @costs[p[0]][p[1]] }
    @unvisited.delete(pos)
    pos
  end
end

if $PROGRAM_NAME == __FILE__
  file = File.read('input15.txt')

  puts(D15.new(file).p1)
  # puts(D15.new(file).p2)
end
