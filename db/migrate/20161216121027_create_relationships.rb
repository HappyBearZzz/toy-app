class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :from_userid
      t.integer :to_userid

      t.timestamps null: false
    end
  end
end
