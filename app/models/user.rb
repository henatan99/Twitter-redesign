class User < ApplicationRecord
    has_many :opinions
    has_many :followers
    has_many :followings
end
