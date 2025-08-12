class AddJoinClassroomsStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :classrooms_students do |t|
      t.belongs_to :classroom
      t.belongs_to :student

      t.timestamps
    end
  end
end
