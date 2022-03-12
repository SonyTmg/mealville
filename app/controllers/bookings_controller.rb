class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
    @my_bookings = @bookings.where(user: current_user)
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def confirm
    @booking = Booking.find(params[:booking_id])
  end

  def create
    # this appears as a section of an event's show page
    @booking = Booking.new(booking_params)
    @event = Event.find(params[:event_id])
    @booking.event = @event
    # @event = Event.find(params[:event_id])
    @booking.user_id = current_user.id
    if @booking.save
      redirect_to booking_confirm_path(booking_id: @booking.id)
      UserMailer.with(user: @booking.event.user, event: @booking.event).booking_request_email.deliver_later
      # render 'success'
    else
      flash[:notice] = "Error processing booking. Try again later."
      flash[:alert] = @booking.errors.full_messages
      render 'events/show'
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

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    redirect_to success_bookings_path
  end

  def message_host
    @booking = Booking.find(params[:booking_id])
    UserMailer.with(user: @booking.event.user, booking: @booking,
                    sender: @booking.user,
                    body: params[:message][:body],
                    subject: params[:message][:subject]).booking_message_host_email.deliver_later
    flash[:success] = "Your message has been sent to the host."
    redirect_back(fallback_location: root_path)
  end

  private
  def booking_params
    params.require(:booking).permit(:event_id, :noguest)
  end

end
