module CzechOldCatholicCalendar
  class Transfers < CalendariumRomanum::Transfers
    # overridden
    def call
      @transferred = {}

      dates = @sanctorale.solemnities.keys.collect do |abstract_date|
        concretize_abstract_date abstract_date
      end.sort

      dates.each do |date|
        tc = @temporale[date]
        next unless tc.solemnity?

        sc = @sanctorale[date]
        next unless sc.size == 1 && sc.first.solemnity?

        loser = [tc, sc.first].sort_by(&:rank).first

        # method copy-pasted from calendarium-romanum, only change was here,
        # removing an Annunciation special case
        transfer_to = free_day_closest_to(date)

        @transferred[transfer_to] = loser
      end

      @transferred
    end

    private

    # overridden
    def free_day_closest_to(date)
      dates_after(date).find {|d| valid_destination?(d) }
    end

    def dates_after(date)
      return to_enum(:dates_after, date) unless block_given?

      1.upto(100) do |i|
        yield date + i
      end

      raise 'this point should never be reached'
    end
  end
end
