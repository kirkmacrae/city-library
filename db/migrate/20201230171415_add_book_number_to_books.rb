class AddBookNumberToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :book_number, :integer
  end
end
