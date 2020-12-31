module CzechOldCatholicCalendar
  class Calendar < CalendariumRomanum::Calendar
    def initialize(year, sanctorale = nil, temporale = nil, vespers: false)
      super(year, sanctorale, temporale, vespers: vespers)

      # use our custom Temporale
      #
      # TODO: it would be better to allow changing default Temporale class
      #   in a declarative fashion, without overriding the constructor like this
      #   (and then having to re-generate transfers)
      @temporale = temporale || Temporale.new(year)

      @transferred = Transfers.call(@temporale, @sanctorale).freeze
    end

    def day(*args, vespers: false)
      r = super(*args, vespers: vespers)

      r.celebrations.delete_if {|c| c.symbol == :saturday_memorial_bvm }

      if r.date.month == 1 && r.date.day == 1
        r.celebrations << Temporale.create_celebration(
          I18n.t('temporale.solemnity.new_year'),
          CzechOldCatholicCalendar::Ranks::SOLEMNITY_GENERAL,
          CzechOldCatholicCalendar::Colours::WHITE
        )
      end

      r
    end
  end
end
