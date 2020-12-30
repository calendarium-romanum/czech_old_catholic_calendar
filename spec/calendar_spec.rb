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
    describe 'there is no downgrading of memorials to commemorations in privileged seasons' do
      it 'octave of Christmas' do
        day = calendar[Date.new(2017, 12, 29)]
        expect(day.celebrations.size).to be 1

        c = day.celebrations.first
        expect(c.cycle).to be :sanctorale
        expect(c.rank).to be COCC::Ranks::MEMORIAL_GENERAL
        expect(c.title).to include 'Becketa' # TODO symbol
      end

      it 'Lent' do
        day = calendar[Date.new(2018, 3, 7)]
        expect(day.celebrations.size).to be 2

        expect(day.celebrations[0]).to be_ferial
        expect(day.celebrations[1]).to be_memorial
        expect(day.celebrations[1].title).to include 'Perpetuy a Felicity'
      end
    end

    it 'solemnity of New Year' do
      day = calendar[Date.new(2018, 1, 1)]
      expect(day.celebrations.size).to be 2
      # two solemnities on a single day - Roman calendar does not allow this
      expect(day.celebrations).to all(be_solemnity)

      expect(day.celebrations[0].title).to include 'Panny Marie' # TODO symbol
      expect(day.celebrations[1].title).to include 'Nový rok' # TODO symbol
    end

    describe '"temporale" celebrations not inherited' do
      it 'Sacred Heart of Jesus' do
        date = CalendariumRomanum::Temporale::Dates.sacred_heart year
        day = calendar[date]

        expect(day.celebrations.size).to be 1
        expect(day.celebrations.first).to be_ferial
      end

      it 'Christ the King' do
        date = CalendariumRomanum::Temporale::Dates.christ_king year
        day = calendar[date]

        expect(day.celebrations.size).to be 1
        expect(day.celebrations.first).to be_sunday
      end

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

    describe 'Sunday special names' do
      it '2nd Sunday in Ordinary Time' do
        day = calendar[Date.new(2018, 1, 14)]

        expect(day.celebrations.first.title)
          .to eq '2. neděle v mezidobí - Svatby v Káně'
      end

      it '34th Sunday in Ordinary Time' do
        day = calendar[Date.new(2018, 11, 25)]

        # 2017 mentionned only in the list of movable feasts at the beginning,
        # not in the calendar entry, but ordos for other years have it in the entry, too
        expect(day.celebrations.first.title)
          .to eq '34. neděle v mezidobí - Opětného příchodu Páně'
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

    describe 'transfering Annunciation' do
      [
        Date.new(2007, 3, 26), # collided with a Sunday of Lent
        Date.new(2008, 3, 31), # collided with Easter Octave; haven't seen an official Old Catholic ordo for this year, but the date is 90% correct
        # 2012
        # 2013
        Date.new(2016, 4, 4), # collided with Good Friday
        Date.new(2018, 4, 9), # collided with Palm Sunday; Roman calendar transfers to an earlier date, Old Catholic one does not
      ].each do |date|
        it date.year do
          calendar = described_class.new(date.year - 1, sanctorale)
          day = calendar[date]

          expect(day.celebrations.size).to be 1
          expect(day.celebrations.first).to be_solemnity
          expect(day.celebrations.first.title).to include 'Zvěstování Páně' # TODO symbol
        end
      end
    end
  end
end
