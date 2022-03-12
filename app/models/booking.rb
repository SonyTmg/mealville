class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :reviews, dependent: :destroy

  enum status: [:pending, :confirmed, :cancelled], _default: "pending"

  # validate :ensure_total_guests_not_exceed_capacity

  # def ensure_total_guests_not_exceed_capacity
  #   if noguest > event.capacity || event.total_guests > event.remaining_capacity
  #     errors.add(:noguest, "cannot exceed maximum capacity")
  #   end
  # end
end
