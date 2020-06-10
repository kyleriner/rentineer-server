class Apartment < ApplicationRecord
    has_many :userApartments
    has_many :users, through: :userApartments
end