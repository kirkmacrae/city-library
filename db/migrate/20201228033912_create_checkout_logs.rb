class CreateCheckoutLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :checkout_logs do |t|
      t.datetime :checkout_date
      t.datetime :due_date
      t.datetime :returned_date
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
