class Host::BookingsController < ApplicationController
  layout "host_dashboard"

  def index
  end

  def confirm
    @booking = Booking.find(params[:booking_id])
    @booking.confirmed!
    flash[:notice] = "Booking confirmed!"
    redirect_back fallback_location: host_events_path
  end
end
