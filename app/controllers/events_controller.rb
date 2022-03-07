class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  def index
    @events = Event.all
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
      redirect_to @event, notice: 'Event was successfully created.'
    else
      flash[:alert] = "Could not create Event."
      render :new
    end
  end

  def my_events
    @user = current_user
    @my_events = @user.events
  end

  def edit
  end


  def update
    if @my_event.update(event_params)
      redirect_to my_events_events_path
    else
      render 'edit'
    end
  end

  def destroy
    @my_event.destroy
    redirect_to my_events_events_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :location, :price, :capacity, :start_time, :end_time, :date, photos: [])
  end
end
