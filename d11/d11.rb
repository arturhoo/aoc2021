# frozen_string_literal: true

require 'pp'

# https://adventofcode.com/2021/day/11
class D11
  def initialize(input)
    lines = input.split("\n")
    @octopus_map = OctopusMap.new(lines)
  end

  def p1
    100.times { @octopus_map.process_step }
    @octopus_map.total_flashes
  end

  def p2
    loop do
      @octopus_map.process_step
      break if @octopus_map.synchronized?
    end
    @octopus_map.total_steps
  end
end

class OctopusMap
  attr_reader :total_flashes, :total_steps

  def initialize(lines)
    @map = lines.map { |l| l.chars.map(&:to_i) }
    reset_flashes
    @total_flashes = 0
    @total_steps = 0
  end

  def neighbour_coords(x, y)
    coords = []
    (-1..1).each do |y_offset|
      (-1..1).each do |x_offset|
        next if y_offset.zero? && x_offset.zero?
        next if (y_offset + y).negative? || y_offset + y >= @map.length
        next if (x_offset + x).negative? || x_offset + x >= @map[0].length

        coords << [x_offset + x, y_offset + y]
      end
    end
    coords
  end

  def process_step
    @map.each_with_index do |line, y_coord|
      line.each_with_index do |_value, x_coord|
        process_octopus(x_coord, y_coord)
      end
    end

    @flash_map.each_with_index do |line, y_coord|
      line.each_with_index do |flashed, x_coord|
        @map[y_coord][x_coord] = 0 if flashed
      end
    end

    @total_steps += 1
    reset_flashes
  end

  def process_octopus(x, y)
    @map[y][x] += 1
    return unless @map[y][x] > 9 && !@flash_map[y][x]

    @total_flashes += 1
    @flash_map[y][x] = true

    neighbour_coords(x, y).each do |n_x, n_y|
      process_octopus(n_x, n_y)
    end
  end

  def synchronized?
    @map.each { |l| l.each { |e| return false if e != 0 } }
    true
  end

  private

  def reset_flashes
    @flash_map = Array.new(@map.length) { Array.new(@map[0].length) { false } }
  end
end

if $PROGRAM_NAME == __FILE__
  file = File.read('input11.txt')

  puts(D11.new(file).p1)
  puts(D11.new(file).p2)
end
