class User < ApplicationRecord
    has_many :opinions, 
        foreign_key: :author_id,
        dependent: :destroy,
        inverse_of: 'author'    
    has_many :followings,
        foreign_key: :follower_id,        
        dependent: :destroy,
        inverse_of: 'follower'
    has_many :followers, through: :followings, foreign_key: :followed_id
end
