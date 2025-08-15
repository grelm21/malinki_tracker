class CreateClassrooms < ActiveRecord::Migration[7.1]
  def change
    create_table :classrooms do |t|
      t.string :name
      t.integer :status
      t.integer :class_format
      t.bigint :wage
      t.text :comment
      t.integer :length
      t.text :schedule, array: true, default: []

      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
