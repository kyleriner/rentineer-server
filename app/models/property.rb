class Property < ApplicationRecord
    has_many :propertyApartments
    has_many :apartments, through: :propertyApartments
end