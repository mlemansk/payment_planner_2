class CreatePmtAdjustments < ActiveRecord::Migration[5.1]
  def change
    create_table :pmt_adjustments do |t|
      t.string :payment_occurence
      t.integer :loan_id
      t.integer :user_id
      t.float :pmt_adjustment
      t.integer :beg_pay_adj
      t.integer :end_pay_adj

      t.timestamps
    end
  end
end
