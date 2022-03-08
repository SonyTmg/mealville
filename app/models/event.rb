class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos

  include PgSearch::Model
  pg_search_scope :search_by_name_description_and_location,
                  against: %i[name description location],
                  using: {
                    tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }
end
