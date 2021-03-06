class Host::EventsController < ApplicationController
  layout "host_dashboard"
  before_action :set_event, only: %i[show edit update destroy]

  def index
    # https://stackoverflow.com/questions/7549851/rails-where-date-is-greater-than-given-date-query
    @events = current_user.events.where('date > ?', DateTime.now)
    @past_events = current_user.events.where('date < ?', DateTime.now)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to host_event_path(id: @event.id), notice: 'Event was successfully created'
    else
      flash[:alert] = "Could not create Event"
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "Event succesfully updated"
      redirect_to host_event_path(id: @event.id)
    else
      flash[:error] = "Event couldn't be updated"
      redirect_back fallback_location: :host_events_path
    end
  end

  def destroy
    @event.destroy
    redirect_to host_events_path
  end

  def checkout
    @event = Event.find(params[:id])
    @booking = Booking.new
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :cuisine, :description, :location, :price, :capacity, :start_time, :end_time, :date, photos: [])
  end
end
