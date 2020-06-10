class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.integer :price_min
      t.integer :price_max
      t.string :address
      t.string :zip
    end
  end
end
