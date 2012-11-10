class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.integer :building_id
      t.string :number

      t.timestamps
    end
  end
end
