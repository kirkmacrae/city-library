class CreateCheckoutLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :checkout_logs do |t|
      t.integer :UserId
      t.integer :BookId
      t.datetime :CheckoutDate
      t.datetime :DueDate
      t.datetime :ReturnedDate
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
