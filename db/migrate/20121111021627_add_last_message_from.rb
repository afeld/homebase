class AddLastMessageFrom < ActiveRecord::Migration
  def change
    add_column :users, :last_message_dm_from_id, :integer
  end
end
