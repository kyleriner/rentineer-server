class CreateUserApartments < ActiveRecord::Migration[6.0]
  def change
    create_table :user_apartments do |t|
      t.integer :user_id
      t.integer :apartment_id
    end
  end
end
