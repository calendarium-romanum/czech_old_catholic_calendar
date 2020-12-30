require 'calendarium-romanum'

module CzechOldCatholicCalendar
  include CalendariumRomanum
end

require 'czech_old_catholic_calendar/version'
require 'czech_old_catholic_calendar/data'
require 'czech_old_catholic_calendar/temporale'
require 'czech_old_catholic_calendar/transfers'
require 'czech_old_catholic_calendar/calendar'
require 'czech_old_catholic_calendar/i18n_setup'

# convenience shortcut
COCC = CzechOldCatholicCalendar
