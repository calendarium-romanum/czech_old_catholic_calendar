module CzechOldCatholicCalendar
  class Temporale < CalendariumRomanum::Temporale
    class << self
      # TODO this is basically copy-pasted piece of CalendariumRomanum::Temporale.
      #   CalendariumRomanum should really provide a better way to override the list of
      #   movable feasts.
      #
      # @api private
      def celebrations
        @celebrations ||=
          begin
            [
              :nativity,
              :holy_family,
              :mother_of_god,
              :epiphany,
              :baptism_of_lord,
              :ash_wednesday,
              :good_friday,
              :holy_saturday,
              :palm_sunday,
              :easter_sunday,
              :ascension,
              :pentecost,
              :holy_trinity,
              :corpus_christi,
              # :mother_of_church,
              # :sacred_heart,
              # :christ_king,
              # :immaculate_heart,
            ].collect do |symbol|
              date_method = symbol
              C.new(
                date_method,
                CalendariumRomanum::Temporale::CelebrationFactory.public_send(symbol)
              )
            end
          end
      end
    end

    private

    # overridden
    def sunday(date, season_week)
      r = super(date, season_week)

      return r if r.nil?

      # TODO we duplicate logic from the parent class. Since special Sunday names
      #   are used in the Roman Catholic church, too, support for this should be moved
      #   upstream to calendarium-romanum
      if season_week.season == CzechOldCatholicCalendar::Seasons::ORDINARY && [2, 34].include?(season_week.week)
        return r.change(title: r.title + ' - ' + I18n.t("temporale.ordinary.sunday_name.#{season_week.week}"))
      end

      r
    end

    def ferial(date, season_week = nil)
      r = super(date, season_week)

      if r.rank == CzechOldCatholicCalendar::Ranks::FERIAL_PRIVILEGED
        return r.change(rank: CzechOldCatholicCalendar::Ranks::FERIAL)
      end

      r
    end
  end
end
