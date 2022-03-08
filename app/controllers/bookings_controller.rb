class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
    @my_bookings = @bookings.where(user: current_user)
  end

  def new
    @booking = Booking.new(event_id: params[:event_id])
  end

  def confirm
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    if @booking.valid?
      @booking.save
      render 'success'
    else
      @booking = Booking.new
      render 'new'
    end
  end

  def create
    # this appears as a section of an event's show page
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    if @booking.valid?
      # redirect_to event_confirm_booking_path(event_id: params[:event_id])
      @booking.save
      UserMailer.with(user: current_user, event: @booking.event).booking_request_email.deliver_later
      render 'success'
    else
      @booking = Booking.new
      flash[:alert] = "Error processing booking. Try again later"
      redirect_back(fallback_location: root_path)
    end
  end

  def success
  end

  def cancel
    @booking = Booking.find(params[:booking_id])
    @booking.cancelled!

    UserMailer.with(user: @booking.event.user, booking: @booking).booking_cancel_email.deliver_later

    flash[:alert] = "You have cancelled your booking."
    redirect_back(fallback_location: root_path)
  end

  private

  def booking_params
    params.require(:booking).permit(:event_id, :user_id)
  end

end
