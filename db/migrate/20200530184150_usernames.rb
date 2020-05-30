class Usernames < ActiveRecord::Migration[6.0]
  def change
    create_table :usernames do |t|
      t.string :adjective
      t.string :noun
    end
  end
end
