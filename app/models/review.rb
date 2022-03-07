class Review < ApplicationRecord
  belongs_to :booking

  validates :rating, inclusion: 0..5
  validates :rating, numericality: { only_integer: true }
end
