# frozen_string_literal: true

require './d15'

describe D15 do
  let(:input) do
    <<~EXAMPLE_INPUT
      1163751742
      1381373672
      2136511328
      3694931569
      7463417111
      1319128137
      1359912421
      3125421639
      1293138521
      2311944581
    EXAMPLE_INPUT
  end

  it 'works for part 1' do
    expect(D15.new(input).p1).to eq(40)
  end

  it 'works for part 2' do
    expect(D15.new(input).p2).to eq(:FIX_ME)
  end
end
