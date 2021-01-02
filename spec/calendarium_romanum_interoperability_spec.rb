# coding: utf-8
require_relative 'spec_helper'

RSpec.describe 'CalendariumRomanum interoperability' do
  describe 'translation strings do not get clobbered through overriding' do
    let(:date) { Date.new(2018, 4, 3) }
    let(:liturgical_year) { date.year - 1 }
    let(:day) { calendar[date] }

    describe 'czech_old_catholic_calendar' do
      let(:calendar) { COCC::Calendar.new liturgical_year }

      it 'has the customized string' do
        expect(day.celebrations.first.title)
          .to eq 'Úterý velikonoční'
      end
    end

    describe 'calendarium-romanum' do
      let(:calendar) { CalendariumRomanum::Calendar.new liturgical_year }

      it 'has the original string' do
        expect(day.celebrations.first.title)
          .to eq 'Úterý v oktávu velikonočním'
      end
    end
  end
end
