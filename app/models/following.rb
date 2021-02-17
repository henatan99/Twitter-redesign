class Following < ApplicationRecord
  belongs_to :follower, foreign_key: :follower_id, class_name: 'User'
  belongs_to :followed, foreign_key: :followed_id, class_name: 'User'

  validates :follower, presence: true
  validates :followed, presence: true
  validates_uniqueness_of :followed, scope: :follower_id
end
