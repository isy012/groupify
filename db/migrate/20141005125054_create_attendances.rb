class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :group_id
      t.integer :user_id

      t.timestamps null: false
	end
	add_index :attendances, :group_id
	add_index :attendances, :user_id
	add_index :attendances, [:group_id, :user_id], unique: true
   
  end
end