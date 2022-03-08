class EventsController < ApplicationController
  before_action :set_event, only: %i[show]
  def index
    @events = Event.all
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude
      }
    end
  end

  def show
    @event = Event.find(params[:id])
    @booking = Booking.new(event_id: @event.id)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
