# coding: utf-8
require_relative 'spec_helper'

RSpec.describe COCC::Calendar do
  let(:year) { 2017 }
  let(:sanctorale) { COCC::Data::GENERAL.load }
  let(:calendar) { described_class.new year, sanctorale }

  it 'uses our custom Temporale by default' do
    expect(calendar.temporale).to be_a COCC::Temporale
  end

  describe 'notable differences from CalendariumRomanum::Calendar' do
    describe '"temporale" celebrations not inherited' do
      it 'Saturday memorial of BVM' do
        saturdays = calendar.each.select {|day| day.date.saturday? }

        expect(saturdays).not_to be_empty # make sure

        expect(saturdays.find {|day| day.celebrations.collect(&:symbol).include? :saturday_memorial_bvm })
          .to be nil
      end

      it 'BVM, Mother of the Church' do
        day = calendar[Date.new(2018, 5, 21)]

        expect(day.celebrations.size).to be 1
        expect(day.celebrations.first).to be_ferial
      end
    end

    # TODO: move to Temporale specs
    describe 'different names for Temporale celebrations' do
      it 'ferials in Ordinary Time' do
        I18n.with_locale(:cs) do
          day = calendar[Date.new(2018, 2, 13)]
          expect(day.celebrations.first.title)
            .to eq 'Úterý po 6. neděli v mezidobí'
        end
      end

      it 'days of the Easter Octave' do
        I18n.with_locale(:cs) do
          day = calendar[Date.new(2018, 4, 3)]
          expect(day.celebrations.first.title)
            .to eq 'Úterý velikonoční'
        end
      end
    end
  end
end
