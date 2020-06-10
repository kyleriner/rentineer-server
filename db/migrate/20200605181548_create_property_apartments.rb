class CreatePropertyApartments < ActiveRecord::Migration[6.0]
  def change
    create_table :property_apartments do |t|
      t.integer :property_id
      t.integer :apartment_id
    end
  end
end
