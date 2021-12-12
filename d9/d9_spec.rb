# frozen_string_literal: true

require './d9'

describe D9 do
  let(:input) do
    <<~EXAMPLE_INPUT
      2199943210
      3987894921
      9856789892
      8767896789
      9899965678
    EXAMPLE_INPUT
  end

  it 'works for part 1' do
    expect(D9.new(input).p1).to eq(15)
  end

  it 'works for part 2' do
    expect(D9.new(input).p2).to eq(1134)
  end
end
