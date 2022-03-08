class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos


  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  include PgSearch::Model
  pg_search_scope :search_by_name_cuisine_description_and_location,
                  against: %i[name cuisine description location],
                  using: {
                    tsearch: { prefix: true }
                  }

  def formatted_date
    date.strftime("%a %d, %B %Y")
  end

  def formatted_start_time
    start_time.strftime("%I:%M %p")
  end

  def formatted_end_time
    end_time.strftime("%I:%M %p")
  end
end
