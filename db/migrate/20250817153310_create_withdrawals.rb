class CreateWithdrawals < ActiveRecord::Migration[7.1]
  def change
    create_table :withdrawals do |t|
      t.bigint :amount_cents
      t.datetime :issued_at

      t.belongs_to :classrooms_student, null: false, foreign_key: true
      t.belongs_to :teacher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
