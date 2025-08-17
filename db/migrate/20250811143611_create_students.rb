class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :name
      t.string :contact_details
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
