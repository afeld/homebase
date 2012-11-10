class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.string :street_number
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.string :country
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
