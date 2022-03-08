class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :user
  enum status: [:pending, :confirmed, :cancelled], _default: "pending"
end
