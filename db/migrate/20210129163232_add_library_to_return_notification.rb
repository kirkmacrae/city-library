class AddLibraryToReturnNotification < ActiveRecord::Migration[6.0]
  def change
    add_reference :return_notifications, :library, null: false, foreign_key: true
  end
end
