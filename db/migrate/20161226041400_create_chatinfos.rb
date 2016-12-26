class CreateChatinfos < ActiveRecord::Migration
  def change
    create_table :chatinfos do |t|
      t.integer :activity_id
      t.integer :user_id
      t.string :content

      t.timestamps null: false
    end
  end
end
