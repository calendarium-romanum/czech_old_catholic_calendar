require 'calendarium-romanum'

module CzechOldCatholicCalendar
  include CalendariumRomanum
end

require 'czech_old_catholic_calendar/version'
require 'czech_old_catholic_calendar/data'
require 'czech_old_catholic_calendar/temporale'

# convenience shortcut
COCC = CzechOldCatholicCalendar
