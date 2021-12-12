# frozen_string_literal: true

require 'Set'

# https://adventofcode.com/2021/day/12
class D12
  def initialize(input)
    @system = Hash.new { |hash, key| hash[key] = [] }
    parse_input(input)
  end

  def p1
    paths = visit_cave('start', [], [])
    paths.length
  end

  def p2
    all_paths = Set[]
    @system.keys.select(&:downcase?).each do |cave|
      next if %w[start end].include?(cave)

      @special_cave = cave
      paths = visit_cave('start', [], [])
      all_paths.merge(paths)
    end
    all_paths.length
  end

  private

  def parse_input(input)
    lines = input.split("\n")
    lines.each do |line|
      cave1, cave2 = line.split('-')
      @system[cave1] << cave2
      @system[cave2] << cave1
    end
  end

  def visit_cave(cave, current_path, possible_paths)
    current_path = current_path.dup
    current_path << cave

    if cave == 'end'
      possible_paths << current_path
      return possible_paths
    end

    connections = @system[cave]
    connections.each do |connected_cave|
      if connected_cave.downcase? && current_path.include?(connected_cave)
        next if connected_cave != @special_cave
        next if current_path.select { |c| c == @special_cave }.length >= 2
      end

      possible_paths = visit_cave(connected_cave, current_path, possible_paths)
    end
    possible_paths
  end
end

class String
  def upcase?
    self == upcase
  end

  def downcase?
    self == downcase
  end
end

if $PROGRAM_NAME == __FILE__
  file = File.read('input12.txt')

  puts(D12.new(file).p1)
  puts(D12.new(file).p2)
end
