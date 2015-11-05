class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
    	t.integer :friend_id
    	t.integer :user_id

      t.timestamps null: false
    end
  end
end
