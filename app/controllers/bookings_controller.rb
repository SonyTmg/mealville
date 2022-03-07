class BookingsController < ApplicationController
  def neww
    @booking = Booking.new(event_id: params[:event_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    if @booking.valid?
      # redirect_to event_confirm_booking_path(event_id: params[:event_id])
      render 'success'
    else
      @booking = Booking.new
      flash[:alert] = "Error processing booking. Try again later"
      render 'new'
    end
  end

  def index
    @bookings = Booking.all
    @my_bookings = @bookings.where(user: current_user)
  end

  def success
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to event_bookings_path(event_id: @booking.event.id)
  end

  private

  def booking_params
    params.require(:booking).permit(:event_id, :user_id)
  end

end
