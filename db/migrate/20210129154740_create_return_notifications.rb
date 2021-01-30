class CreateReturnNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :return_notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :book_number

      t.timestamps
    end
  end
end
