class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title
      t.string :content
      t.string :category
      t.timestamp :start_at
      t.timestamp :end_at
      t.string :location
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
