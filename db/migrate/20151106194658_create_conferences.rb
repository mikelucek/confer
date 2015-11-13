class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :user_id
      t.string :conference_id
      t.string :conference_description
      t.string :conference_summary
      t.string :conference_date

      t.timestamps null: false
    end
  end
end
