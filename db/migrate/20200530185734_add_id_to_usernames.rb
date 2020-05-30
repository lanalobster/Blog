class AddIdToUsernames < ActiveRecord::Migration[6.0]
  def change
    change_column :usernames, :id, :integer, auto_increment: true
  end
end
