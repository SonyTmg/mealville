class DashboardController < ApplicationController
  def index
    @upcoming_bookings = Booking.includes(:event).where("bookings.user_id = ? AND events.date > ?", current_user.id, Date.today).references(:events)
    @past_bookings = Booking.includes(:event).where("bookings.user_id = ? AND events.date < ?", current_user.id, Date.today).references(:events)
  end
end
