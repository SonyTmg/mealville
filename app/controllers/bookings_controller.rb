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
    @event = Event.find(params[:event_id])
    # this appears as a section of an event's show page
    @booking = Booking.new(booking_params)
    @booking.event = @event
    @booking.user_id = current_user.id
    if @booking.valid?
      # redirect to checkout
      Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
      session = Stripe::Checkout::Session.create({
        line_items: [{
          price_data: {
            currency: 'aud',
            product_data: {
              name: @event.name,
            },
            unit_amount: @event.price_cents,
          },
          quantity: 1,
        }],
        mode: 'payment',
        # redirect urls after checkout is complete
        success_url: complete_booking_event_bookings_url, # should redirect to success page
        cancel_url: event_url(@event), # should redirect to show page maybe
        # transferring funds
        payment_intent_data: {
          transfer_data: {
            destination: @event.user.stripe_user_id.to_s,
          }
        }
      })

      # this redirects to checkout session hosted on stripe
      redirect_to session.url
      # redirect_to event_confirm_booking_path(event_id: params[:event_id])
    else
      render 'events/show'
    end
  end

  def complete_booking
    @event = Event.find(params[:event_id])
    @booking = Booking.new
    @booking.event = @event
    @booking.user_id = current_user.id
    @booking.save
    UserMailer.with(user: current_user, event: @booking.event).booking_request_email.deliver_later
    render 'success'
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
