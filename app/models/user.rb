class User < ApplicationRecord
    has_many :opinions, 
        foreign_key: :author_id,
        dependent: :destroy
            
    has_many :followings, class_name: 'Following', foreign_key: 'follower_id'
    has_many :inverse_followings, class_name: 'Following', foreign_key: 'followed_id'
        
    has_many :followeds, through: :followings, foreign_key: 'followed_id'
    has_many :followers, through: :inverse_followings, foreign_key: 'follower_id'

    has_one_attached :photo
    has_one_attached :coverimage

    validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
    validates :fullname, presence: true, length: { maximum: 30 }    

    def follow(user)
        following = followings.build(followed: user)        
    end    
    
end
