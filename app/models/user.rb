class User < ApplicationRecord
  attr_accessor :skip_password_validation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 stripe_connect]
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

  def name
    full_name || "#{first_name} #{last_name}"
  end

  def can_receive_payments?
    stripe_uid? &&  provider? && access_code? && publishable_key?
  end

  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
