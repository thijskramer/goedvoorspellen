class MatchesController < ApplicationController
  before_action :set_match, only: [:show]
  require 'icalendar'
  require 'icalendar/tzinfo'

  def index
    @matches = Match.all.order(:startDate, :number)
    matchdates = Array.new
    @matches.each do |m| 
      matchdates.push(m.startDate)
    end
    @matchdates = matchdates.uniq
  end

  def show
  end

  def calendar 
    cal = Icalendar::Calendar.new

    achtstefinalecounter = 1
    kwartfinalecounter = 1
    halvefinalecounter = 1

    # add timezones
    cal.timezone do |t|
      t.tzid = "Brasilia"

      t.daylight do |d|
        d.tzoffsetfrom = "-0400"
        d.tzoffsetto   = "-0300"
        d.tzname       = "BRST"
        d.dtstart      = "19700308T020000"
        d.rrule        = "FREQ=YEARLY;BYMONTH=3;BYDAY=2SU"
      end

      t.standard do |s|
        s.tzoffsetfrom = "-0300"
        s.tzoffsetto   = "-0400"
        s.tzname       = "BRT"
        s.dtstart      = "19701101T020000"
        s.rrule        = "FREQ=YEARLY;BYMONTH=11;BYDAY=1SU"
      end
    end

    cal.timezone do |t|
      t.tzid = "Santiago"

      t.daylight do |d|
        d.tzoffsetfrom = "-0500"
        d.tzoffsetto   = "-0400"
        d.tzname       = "ADT"
        d.dtstart      = "19700308T020000"
        d.rrule        = "FREQ=YEARLY;BYMONTH=3;BYDAY=2SU"
      end

      t.standard do |s|
        s.tzoffsetfrom = "-0400"
        s.tzoffsetto   = "-0500"
        s.tzname       = "AST"
        s.dtstart      = "19701101T020000"
        s.rrule        = "FREQ=YEARLY;BYMONTH=11;BYDAY=1SU"
      end
    end

    cal.timezone do |t|
      t.tzid = "Europe/Amsterdam"

      t.daylight do |d|
        d.tzoffsetfrom = "+0100"
        d.tzoffsetto   = "+0200"
        d.tzname       = "CEST"
        d.dtstart      = "19700308T020000"
        d.rrule        = "FREQ=YEARLY;BYMONTH=3;BYDAY=2SU"
      end

      t.standard do |s|
        s.tzoffsetfrom = "+0200"
        s.tzoffsetto   = "+0100"
        s.tzname       = "EST"
        s.dtstart      = "19701101T020000"
        s.rrule        = "FREQ=YEARLY;BYMONTH=11;BYDAY=1SU"
      end
    end

    Match.all.each do |m|
        # re-calculate start and end time
        # offset = m.stadium.timezone == 'Brasilia' ? 5 : m.stadium.timezone == 'Santiago' ? 6 : 0
        offset = 2
        startd = m.startDate - offset.hours
        endd = m.endDate - offset.hours

        # create event
        event = Icalendar::Event.new
        event.dtstart = Icalendar::Values::DateTime.new(startd)
        event.dtend   = Icalendar::Values::DateTime.new(endd)
        event.summary = m.name
        event.url = 'http://www.goedvoorspellen.nl/wedstrijden/' + m.slug
        event.location = m.stadium.name + ", " + m.stadium.city
        event.last_modified = Icalendar::Values::DateTime.new(m.updated_at.strftime('%Y%m%d') + 'T' + m.updated_at.strftime('%H%M%S'))
        if m.matchtype_id == 1
            event.description = "Wedstrijd in groep " + m.group
        end
        if m.matchtype_id == 2
            event.description = "Achtste finale " + achtstefinalecounter.to_s
            event.summary = "Achtste finale: " + m.name
            achtstefinalecounter += 1
        end
        if m.matchtype_id == 3
            event.description = "Kwartfinale " + kwartfinalecounter.to_s
            event.summary = "Kwartfinale: " + m.name
            kwartfinalecounter += 1
        end
        if m.matchtype_id == 4
            event.description = "Halve finale " + halvefinalecounter.to_s
            event.summary = "Halve finale: " + m.name
            halvefinalecounter += 1
        end
        if m.matchtype_id == 5
            event.description = "Wedstrijd om de derde plaats"
            event.summary = "3e plaats: " + m.name
            
        end
        if m.matchtype_id == 6
            event.description = "Finale"
            event.summary = "Finale: " + m.name
        end
        event.status
        cal.add_event(event)
    end

    cal.publish
    cal_string = cal.to_ical
    puts cal_string
    # cal_string = cal_string.sub! 'METHOD:PUBLISH', "METHOD:PUBLISH\nX-WR-CALNAME:WK 2014\nX-WR-TIMEZONE:Europe/Amsterdam\nX-WR-CALDESC:Goedvoorspellen.nl"
    render text: cal_string, content_type: "text/calendar"
    # render text: "<pre>" + cal_string + "</pre>"
  end

  private
    def set_match
      @match = Match.friendly.find(params[:id])
    end
end
