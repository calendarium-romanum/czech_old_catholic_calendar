module CzechOldCatholicCalendar
  class Data
    extend CzechOldCatholicCalendar::Enum

    class SanctoraleFile < CalendariumRomanum::Data::SanctoraleFile
      def initialize(base_name)
        super(base_name)

        @path = File.expand_path('../../data/' + base_name, File.dirname(__FILE__))
      end
    end

    GENERAL = SanctoraleFile.new 'general.txt'
    PRAHA = SanctoraleFile.new 'praha.txt'
    SUMPERK = SanctoraleFile.new 'sumperk.txt'

    values(index_by: :siglum) do
      [
        GENERAL,
        PRAHA,
        SUMPERK,
      ]
    end
  end
end
