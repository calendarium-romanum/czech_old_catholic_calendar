require_relative 'spec_helper'

RSpec.describe 'stuff from CalendariumRomanum' do
  describe 'inherited unchanged' do
    it 'main classes' do
      expect(COCC::Temporale).to be < CR::Temporale
      expect(COCC::Sanctorale).to be CR::Sanctorale
      expect(COCC::Calendar).to be < CR::Calendar
    end

    it 'constants/enumerations' do
      expect(COCC::Colours).to be CR::Colours
      expect(COCC::Seasons).to be CR::Seasons
      expect(COCC::Ranks).to be CR::Ranks
    end
  end

  describe 'not inherited' do
    it 'temporale extensions' do
      expect(COCC::Temporale::Extensions).not_to be_const_defined 'Extensions'
    end
  end
end
