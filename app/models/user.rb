class User < ApplicationRecord
  attr_accessor :skip_password_validation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :events, dependent: :destroy
  has_many :bookings

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

  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
