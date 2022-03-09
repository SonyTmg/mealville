class User < ApplicationRecord
  attr_accessor :skip_password_validation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :events, dependent: :destroy
  has_many :bookings, through: :events

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
    reviews = []
    events  = self.events
    sum     = 0

    events.each do |event|
      reviews += event.reviews
    end

    reviews.each do |review|
      sum += review.rating
    end

    sum / reviews.count.to_f
  end

  def all_reviews
    reviews = []
    events  = self.events

    events.each do |event|
      reviews += event.reviews
    end

    reviews
  end

  def name
    full_name || "#{first_name} #{last_name}"
  end



  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
