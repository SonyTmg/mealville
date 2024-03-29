class User < ApplicationRecord
  attr_accessor :skip_password_validation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :events, dependent: :destroy
  has_many :bookings
  has_many :reviews, foreign_key: :for_user

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    where(uid: uid).first_or_initialize do |user|
      user.uid = uid
      user.full_name = full_name
      user.email = email
      user.avatar_url = avatar_url
      user.skip_password_validation = true
      user.save!
    end
  end

  def average_rating
    sum = 0

    reviews.each do |review|
      sum += review.rating
    end

    sum / reviews.count.to_f
  end

  def name
    full_name || "#{first_name} #{last_name}"
  end

  # return bookings for past hosted events if user is hosts
  def confirmed_bookings_for_hosted_events
    return [] unless host

    past_hosted_events.map do |event|
      event.bookings.select do |booking|
        booking.confirmed?
      end
    end.flatten
  end

  def past_hosted_events
    return [] unless host

    events.includes(:bookings).where('date < ?', DateTime.now)
  end

  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
