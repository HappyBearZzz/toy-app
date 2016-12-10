class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :hashed_password
      t.string :no
      t.integer :age
      t.string :sex
      t.string :college
      t.string :major
      t.string :school_year
      t.text :description
      t.string :salt

      t.timestamps null: false
    end
  end
end
