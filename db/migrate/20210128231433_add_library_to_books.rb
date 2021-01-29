class AddLibraryToBooks < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :library, foreign_key: true
    change_column_null :books, :library_id, false
  end
end
