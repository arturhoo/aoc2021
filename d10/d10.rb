# frozen_string_literal: true

require 'Set'
require 'pp'

SCOREBOARD = {
  '}' => 1197,
  ']' => 57,
  ')' => 3,
  '>' => 25_137
}.freeze

# https://adventofcode.com/2021/day/10
class D10
  def initialize(input)
    lines = input.split("\n")
    @lines = lines.map { |l| Line.new(l) }
  end

  def p1
    points = 0
    @lines.each do |line|
      corrupt, token = line.corrupt?
      points += SCOREBOARD[token] if corrupt
    end
    points
  end

  def p2
    :ok
  end
end

OPENING = Set['[', '(', '{', '<'].freeze
CLOSING = Set[']', ')', '}', '>'].freeze
MAP = {
  '}' => '{',
  ']' => '[',
  ')' => '(',
  '>' => '<'
}.freeze

class Line
  def initialize(line_str)
    @line = line_str.chars
  end

  def corrupt?
    stack = []
    @line.each do |token|
      if OPENING.include?(token)
        stack << token
        next
      end
      matching_chunk = MAP[token]
      return true, token if stack[-1] != matching_chunk

      stack.pop
    end
    [false, nil]
  end
end

if $PROGRAM_NAME == __FILE__
  file = File.read('input10.txt')

  puts(D10.new(file).p1)
  puts(D10.new(file).p2)
end
