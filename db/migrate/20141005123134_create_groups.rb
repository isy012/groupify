class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.text :title
      t.datetime :when
      t.integer :seats
      t.text :content

      t.timestamps
    end
  end
end
