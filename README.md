# czech_old_catholic_calendar

![Build Status](https://github.com/calendarium-romanum/czech_old_catholic_calendar/actions/workflows/ci.yml/badge.svg)

This repository contains a Ruby gem computing liturgical calendar
of the [Czech Old Catholic Church (Starokatolická církev v ČR)][starokatolici].

Since the calendar system is very similar to the post-Vatican II Roman Catholic one,
functionality of the [calendarium-romanum][caro] gem is reused as much as possible.
(In fact, one of the main purposes of this project is to try out how un/suitable
[calendarium-romanum][caro] is for such projects.)

## Status

Based on comparison of computed results with official ordo published by the church
([2015](https://docplayer.cz/26220917-Liturgicky-kalendar-2015-2016-biskupsky-ordinariat-starokatolicke-cirkve-v-cr-praha-2015.html),
[2016](https://docplayer.cz/45554176-Liturgicky-kalendar-2016-2017.html),
[2017](https://docplayer.cz/68322372-Liturgicky-kalendar-2017-2018-praha-2017.html)
[2020](http://starokatolici.eu/wp-content/uploads/2020/11/direkt%C3%A1%C5%99-2020-2021.pdf)),
the library seems to be feature-complete, or at least very close to it.
Bug reports are welcome.

## Installation

**The instructions below won't work, the gem has not been released yet.**

Add this line to your application's Gemfile:

```ruby
gem 'czech_old_catholic_calendar'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install czech_old_catholic_calendar

## Usage

Public API is almost exactly the same as that of [calendarium-romanum][caro], just with a different
name of the top-level module. Please refer to [calendarium-romanum][caro]'s documentation.

Typical usage may look like this:

```ruby
require 'czech_old_catholic_calendar'

# GENERAL can be replaced with PRAHA or SUMPERK in order to get proper celebrations
# of the parishes of Prague and Sumperk, respectively
# (the only two parishes with proper celebrations listed in the calendar of the 2007 missal)
sanctorale = CzechOldCatholicCalendar::Data::GENERAL.load_with_parents

calendar = CzechOldCatholicCalendar::PerpetualCalendar.new(sanctorale: sanctorale)

# retrieve liturgical details of today
day = calendar[Date.today]
```

## License

`czech_roman_catholic_calendar` is free software under the terms of the MIT license
(see [LICENSE](/LICENSE)).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

[starokatolici]: https://www.starokatolici.cz/
[caro]: https://github.com/igneus/calendarium-romanum
