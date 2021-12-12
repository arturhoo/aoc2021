# frozen_string_literal: true

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
    :ok
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
    connections.each do |connected_caves|
      next if connected_caves.downcase? && current_path.include?(connected_caves)

      possible_paths = visit_cave(connected_caves, current_path, possible_paths)
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
