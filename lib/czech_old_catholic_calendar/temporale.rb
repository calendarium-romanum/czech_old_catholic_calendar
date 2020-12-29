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
              :sacred_heart,
              :christ_king,
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
  end
end
