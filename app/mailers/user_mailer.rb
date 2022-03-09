require 'icalendar/tzinfo'

class UserMailer < ApplicationMailer
  default from: 'info@mealville.xyz'

  def booking_request_email
    @user = params[:user]
    @event = params[:event]

    mail(to: @user.email, subject: "You have a request for a booking.")
  end

  def booking_confirm_email
    @user = params[:user]
    @booking = params[:booking]

    cal = Icalendar::Calendar.new

    # Parse Event date as 2022-12-31 format
    event_date = @booking.event.date.strftime("%Y-%m-%d")
    # Parse start and end time as HH:MM format
    start_time = @booking.event.start_time.strftime("%H:%M")
    end_time = @booking.event.end_time.strftime("%H:%M")

    # Join date with time so it becomes 2022-12-31 08:00
    event_start = Time.parse("#{event_date} #{start_time}")
    event_end = Time.parse("#{event_date} #{end_time}")

    tzid = "Australia/Melbourne"
    tz = TZInfo::Timezone.get tzid

    timezone = tz.ical_timezone event_start
    cal.add_timezone timezone

    cal.event do |e|
      e.dtstart = Icalendar::Values::DateTime.new event_start, 'tzid' => tzid
      e.dtend   = Icalendar::Values::DateTime.new event_end, 'tzid' => tzid
      e.summary = "#{@booking.event.name} on #{@booking.event.formatted_date}"
      e.description = "Join #{@booking.event.name} on #{@booking.event.formatted_date}. Starts at #{@booking.event.formatted_start_time}"
      e.organizer = "mailto:#{@booking.event.user.email}"
      e.organizer = Icalendar::Values::CalAddress.new("mailto:#{@booking.event.user.email}", cn: @booking.event.user.name)
    end

    attachments['event.ics'] = cal.to_ical

    mail(to: @user.email, subject: "Your booking has been confirmed.")
  end

  def booking_cancel_email
    @user = params[:user]
    @booking = params[:booking]
    mail(to: @user.email, subject: "A booking to your event has been cancelled.")
  end
end
