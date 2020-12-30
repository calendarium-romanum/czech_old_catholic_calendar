module CzechOldCatholicCalendar
  class Calendar < CalendariumRomanum::Calendar
    def day(*args, vespers: false)
      r = super(*args, vespers: vespers)
      r.celebrations.delete_if {|c| c.symbol == :saturday_memorial_bvm }
      r
    end
  end
end
