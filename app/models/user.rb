class User < ApplicationRecord
    has_many :userApartments
    has_many :apartments, through: :userApartments
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }
end