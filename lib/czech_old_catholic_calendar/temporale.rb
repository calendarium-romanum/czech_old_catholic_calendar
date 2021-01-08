module CzechOldCatholicCalendar
  class Temporale < CalendariumRomanum::BaseTemporale

    set_seasons CalendariumRomanum::Seasons.all
    celebration_dates CalendariumRomanum::Temporale::Dates

    celebration :nativity
    celebration :holy_family
    celebration :mother_of_god
    celebration :epiphany
    celebration :baptism_of_lord
    celebration :ash_wednesday
    celebration :good_friday
    celebration :holy_saturday
    celebration :palm_sunday
    celebration :easter_sunday
    celebration :ascension
    celebration :pentecost
    celebration :holy_trinity
    celebration :corpus_christi

    # @return [Date]
    def first_advent_sunday
      CalendariumRomanum::Temporale::Dates.public_send __method__, year
    end

    private

    # overridden
    def sunday(date, season_week)
      r = super(date, season_week)

      return r if r.nil?

      # TODO we duplicate logic from the parent class. Since special Sunday names
      #   are used in the Roman Catholic church, too, support for this should be moved
      #   upstream to calendarium-romanum
      season = season_week.season
      week = season_week.week
      if season == CzechOldCatholicCalendar::Seasons::ORDINARY && [2, 34].include?(week)
        return r.change(title: r.title + ' - ' + I18n.t("temporale.ordinary.sunday_name.#{week}"))
      end

      r
    end

    def ferial(date, season_week)
      r = super(date, season_week)

      if r.rank == CzechOldCatholicCalendar::Ranks::FERIAL_PRIVILEGED
        return r.change(rank: CzechOldCatholicCalendar::Ranks::FERIAL)
      end

      r
    end
  end
end
