class JoinStreetNumberAndStreet < ActiveRecord::Migration
  def change
    remove_column :buildings, :street_number
  end
end
