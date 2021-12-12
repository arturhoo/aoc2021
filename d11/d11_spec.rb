# frozen_string_literal: true

require './d11'

describe D11 do
  let(:input) do
    <<~EXAMPLE_INPUT
      5483143223
      2745854711
      5264556173
      6141336146
      6357385478
      4167524645
      2176841721
      6882881134
      4846848554
      5283751526
    EXAMPLE_INPUT
  end

  it 'works for part 1' do
    expect(D11.new(input).p1).to eq(1656)
  end

  it 'works for part 2' do
    expect(D11.new(input).p2).to eq(195)
  end
end
