class Review < ApplicationRecord
  # User to user review modeling
  # https://stackoverflow.com/questions/20067018/rails-4-users-reviews-for-users-how-to-do-this
  # https://stackoverflow.com/questions/31936481/how-to-add-foreign-key-in-rails-migration-with-different-table-name
  belongs_to :for_user, class_name: 'User'
  belongs_to :by_user, class_name: 'User'

  validates :rating, inclusion: 0..5
  validates :rating, numericality: { only_integer: true }

  scope :reviews_for, ->(user) { where("for_user = ?", user) }
  scope :reviews_by,  ->(user) { where("by_user = ?", user) }
end
