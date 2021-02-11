class Opinion < ApplicationRecord
    belongs_to :author, foreign_key: :author_id, class_name: 'User'

    validates :author, presence: true, uniqueness: true
    validates :text, presence: true, length: { minimum: 1, maximum: 100 }
end
