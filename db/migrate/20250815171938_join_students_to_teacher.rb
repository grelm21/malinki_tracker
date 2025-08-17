class JoinStudentsToTeacher < ActiveRecord::Migration[7.1]
  def change
    create_table :students_teachers, id: false do |t|
      t.belongs_to :teacher, foreign_key: true
      t.belongs_to :student, foreign_key: true
    end
  end
end
