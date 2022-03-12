class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :reviews, dependent: :destroy

  enum status: [:pending, :confirmed, :cancelled], _default: "pending"

  validate :host_cannot_book_their_own_event
  validate :user_cannot_do_multiple_booking_for_an_event

  # validate :ensure_total_guests_not_exceed_capacity

  # def ensure_total_guests_not_exceed_capacity
  #   if noguest > event.capacity || event.total_guests > event.remaining_capacity
  #     errors.add(:noguest, "cannot exceed maximum capacity")
  #   end
  # end

  def host_cannot_book_their_own_event
    if event.user_id == user.id
      errors.add(:base, :cannot_book_own_event, message: "You cannot book in your own events")
    end
  end

  def user_cannot_do_multiple_booking_for_an_event
    if user.bookings.map(&:event_id).include?(event.id)
      errors.add(:base, :already_booked, message: "You already have a booking for this event")
    end
  end
end
