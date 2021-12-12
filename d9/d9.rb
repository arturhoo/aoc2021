# frozen_string_literal: true

require 'pp'

# https://adventofcode.com/2021/day/9
class D9
  def initialize(input)
    lines = input.split("\n")
    @heightmap = Heightmap.new(lines)
  end

  def p1
    @heightmap.low_points.map { |x, y| @heightmap.coord_risk(x, y) }.sum
  end

  def p2
    :ok
  end
end

class Heightmap
  def initialize(lines)
    @map = lines.map { |l| l.chars.map(&:to_i) }
  end

  def low_points
    points = []
    @map.each_with_index do |line, y_coord|
      line.each_with_index do |value, x_coord|
        points << [x_coord, y_coord] if neighbour_coords(x_coord, y_coord)
                                        .select { |x, y| @map[y][x] <= value }
                                        .empty?
      end
    end
    points
  end

  def neighbour_coords(x, y)
    coords = []
    [[0, -1], [1, 0], [0, 1], [-1, 0]].each do |x_offset, y_offset|
      next if (y_offset + y).negative? || y_offset + y >= @map.length
      next if (x_offset + x).negative? || x_offset + x >= @map[0].length

      coords << [x_offset + x, y_offset + y]
    end
    coords
  end

  def coords_to_values(coords)
    coords.map { |x, y| @map[y][x] }
  end

  def coord_risk(x, y)
    @map[y][x] + 1
  end
end

if $PROGRAM_NAME == __FILE__
  file = File.read('input9.txt')

  puts(D9.new(file).p1)
  puts(D9.new(file).p2)
end
