class BookingsController < ApplicationController
  def new
    @booking = Booking.new(event_id: params[:event_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    if @booking.valid?
      # redirect_to event_confirm_booking_path(event_id: params[:event_id])
      render 'new'
    else
      @booking = Booking.new
      flash[:alert] = "Error processing booking. Try again later"
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @bookings = Booking.all
    @my_bookings = @bookings.where(user: current_user)
  end

end
