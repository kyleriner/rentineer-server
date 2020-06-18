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
      t.string :phone
      t.boolean :dog_friendly
      t.boolean :cat_friendly
      t.string :neighborhood
      t.integer :year_built
      
    end
  end
end
