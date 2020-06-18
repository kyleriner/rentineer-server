class CreateUserProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :user_properties do |t|
      t.integer :user_id
      t.integer :property_id
    end
  end
end
