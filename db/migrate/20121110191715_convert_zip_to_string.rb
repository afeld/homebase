class ConvertZipToString < ActiveRecord::Migration
  def change
    change_column :buildings, :zip, :string
  end
end
