class User < ApplicationRecord
    has_many :userProperties
    has_many :properties, through: :userProperties
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }
end