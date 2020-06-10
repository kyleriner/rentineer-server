class PropertyApartment < ApplicationRecord
    belongs_to :apartment
    belongs_to :property
end