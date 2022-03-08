class EventsController < ApplicationController
  before_action :set_event, only: %i[show]

  def index
    if params[:query].present?
      @events = Event.search_by_name_description_and_location(params[:query])
    else
      @events = Event.all
    end
    filter_by_date if params[:dates].present?
  end

  def show
    @event = Event.find(params[:id])
    @booking = Booking.new(event_id: @event.id)
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
