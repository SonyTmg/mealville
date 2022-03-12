class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_event, only: %i[show]

  def index
    @events = Event.upcoming_events
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window: render_to_string(partial: "info_window", locals: { event: event })
      }
    end
    if params[:query].present?
      @events = Event.search_by_name_cuisine_description_and_location(params[:query])
    else
      @events = Event.upcoming_events
    end
    filter_by_date if params[:dates].present?
  end

  def show
    @event = Event.find(params[:id])
    @booking = Booking.new(event_id: @event.id)
    @markers = [{
      lat: @event.latitude,
      lng: @event.longitude,
      info_window: render_to_string(partial: "info_window", locals: { event: @event })
    }]
  end

  private

  def filter_by_date
    dates = params[:dates].split('to')
    start_date = Date.parse(dates.first)
    end_date = Date.parse(dates[1])
    @events = @events.where(date: start_date..end_date)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
