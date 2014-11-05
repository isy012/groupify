class AddPositionToAttendance < ActiveRecord::Migration
  def change
    add_column :attendances, :position, :integer
  end
end
