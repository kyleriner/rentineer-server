class Property < ApplicationRecord
    has_many :images

    has_many :propertyApartments
    has_many :apartments, through: :propertyApartments

    has_many :userProperties
    has_many :users, through: :userProperties
end