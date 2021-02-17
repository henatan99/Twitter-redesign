class Opinion < ApplicationRecord
  belongs_to :author, foreign_key: :author_id, class_name: 'User'

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }

  validates :author, presence: true
  validates :text, presence: true, length: { minimum: 1, maximum: 100 }
end
