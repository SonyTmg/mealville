class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :user

  enum status: [:pending, :confirmed, :cancelled], _default: "pending"

  validate :host_cannot_book_their_own_event, on: :create

  validate :ensure_total_guests_not_exceed_capacity, on: :create

  validates :noguest, :numericality => { :greater_than_or_equal_to => 1 }

  def ensure_total_guests_not_exceed_capacity
    if noguest > event.capacity || noguest > event.remaining_capacity
      errors.add(:noguest, "cannot exceed maximum capacity")
    end
  end

  def host_cannot_book_their_own_event
    if event.user_id == user.id
      errors.add(:base, :cannot_book_own_event, message: "You cannot book in your own events")
    end
  end
end
