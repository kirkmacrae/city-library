require "application_system_test_case"

class ReturnNotificationsTest < ApplicationSystemTestCase
  setup do
    @return_notification = return_notifications(:one)
  end

  test "visiting the index" do
    visit return_notifications_url
    assert_selector "h1", text: "Return Notifications"
  end

  test "creating a Return notification" do
    visit return_notifications_url
    click_on "New Return Notification"

    fill_in "Book number", with: @return_notification.book_number
    fill_in "User", with: @return_notification.user_id
    click_on "Create Return notification"

    assert_text "Return notification was successfully created"
    click_on "Back"
  end

  test "updating a Return notification" do
    visit return_notifications_url
    click_on "Edit", match: :first

    fill_in "Book number", with: @return_notification.book_number
    fill_in "User", with: @return_notification.user_id
    click_on "Update Return notification"

    assert_text "Return notification was successfully updated"
    click_on "Back"
  end

  test "destroying a Return notification" do
    visit return_notifications_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Return notification was successfully destroyed"
  end
end
