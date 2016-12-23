class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from_userid
      t.integer :to_userid
      t.string :content

      t.timestamps null: false
    end
  end
end
