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
end
