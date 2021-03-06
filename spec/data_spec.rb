require_relative 'spec_helper'

RSpec.describe COCC::Data do
  it 'is different from CalendariumRomanum' do
    expect(described_class).not_to be CR::Data
  end

  it 'contains expected data files' do
    expect(described_class.all).to eq [described_class::GENERAL, described_class::PRAHA, described_class::SUMPERK]
    expect(described_class::GENERAL).to be_a described_class::SanctoraleFile
  end

  describe 'the data file can be loaded' do
    described_class.each do |d|
      it d.siglum do
        sanctorale = d.load_with_parents

        expect(sanctorale).to be_a COCC::Sanctorale
        expect(sanctorale).not_to be_empty
      end
    end
  end

  it 'celebration symbols match those of calendarium-romanum' do
    symbols = lambda do |data|
      Set.new data
                .load
                .each_day
                .flat_map {|_, celebrations| celebrations }
                .collect(&:symbol)
                .compact
    end

    cr_symbols = symbols.(CR::Data::GENERAL_ROMAN_ENGLISH) + symbols.(CR::Data::CZECH)
    cocc_symbols = symbols.(COCC::Data::GENERAL)

    # All COCC symbols are included in CR symbols,
    # i.e. only celebrations shared with the General Roman Calendar or calendar of
    # Czech Roman Catholic dioceses have (matching) symbols.
    expect(cocc_symbols).to be < cr_symbols
  end
end
