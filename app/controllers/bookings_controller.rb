class BookingsController < ApplicationController
  def new
    @booking = Booking.new(event_id: params[:event_id])
  end


end
