class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  has_many_attached :photos
  monetize :price_cents

  validates :name,
            :cuisine,
            :price,
            :description,
            :capacity,
            :location,
            :date,
            :start_time,
            :end_time,
            :photos, presence: true

  validate :event_date_cannot_be_in_the_past
  validate :end_time_cannot_be_before_start_time

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  include PgSearch::Model
  pg_search_scope :search_by_name_cuisine_description_and_location,
                  against: %i[name cuisine description location],
                  using: {
                    tsearch: { prefix: true }
                  }

  scope :upcoming_events, -> { where('date > ?', Date.today) }

  # def total_guests
  #   bookings.sum{ |booking| booking.noguest || 0 }
  # end

  # def remaining_capacity
  #     capacity - total_guests
  # end

  def formatted_date
    date.strftime("%a %d, %B %Y")
  end

  def formatted_start_time
    start_time.strftime("%I:%M %p")
  end

  def formatted_end_time
    end_time.strftime("%I:%M %p")
  end

  def event_date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if date.present? && date < Date.today
  end

  def end_time_cannot_be_before_start_time
    if (start_time.present? && end_time.present?) && (end_time < start_time)
      errors.add(:end_time, "can't before start time")
    end
  end
end
