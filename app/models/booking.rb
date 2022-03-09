class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :reviews, dependent: :destroy

  enum status: [:pending, :confirmed, :cancelled], _default: "pending"
end
