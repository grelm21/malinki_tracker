class CreateDepositsWithdrawals < ActiveRecord::Migration[7.1]
  def change
    create_table :deposits_withdrawals, id: false do |t|
      t.belongs_to :deposit, null: false, foreign_key: true
      t.belongs_to :withdrawal, null: false, foreign_key: true
      t.timestamps
    end
  end
end
