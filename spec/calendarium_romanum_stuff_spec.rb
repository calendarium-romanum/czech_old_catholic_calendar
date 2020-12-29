require_relative 'spec_helper'

RSpec.describe 'stuff taken unchanged from CalendariumRomanum' do
  it 'main classes' do
    expect(COCC::Temporale).to be CR::Temporale
    expect(COCC::Sanctorale).to be CR::Sanctorale
    expect(COCC::Calendar).to be CR::Calendar
  end

  it 'constants/enumerations' do
    expect(COCC::Colours).to be CR::Colours
    expect(COCC::Seasons).to be CR::Seasons
    expect(COCC::Ranks).to be CR::Ranks
  end
end
