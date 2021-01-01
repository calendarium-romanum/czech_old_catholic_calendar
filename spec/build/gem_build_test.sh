#!/bin/bash

GEMNAME=czech_old_catholic_calendar

set -e # fail on first error

echo 'Running gem build test'

## build
gem build czech_old_catholic_calendar.gemspec

## install
GEMSET=gem_build_test_gemset

# determine gem file name
VERSION=`ruby -Ilib -r$GEMNAME/version -e 'puts CzechOldCatholicCalendar::VERSION'`
GEM=$GEMNAME-$VERSION.gem

rvm gemset create $GEMSET
rvm @$GEMSET do gem install --no-document $GEM

## test loading in a program
rvm @$GEMSET do ruby -r$GEMNAME -e 'puts CzechOldCatholicCalendar::VERSION'
echo $?

## clean
rvm gemset delete --force $GEMSET

echo 'Gem build test finished successfully'
