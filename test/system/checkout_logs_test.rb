require "application_system_test_case"

class CheckoutLogsTest < ApplicationSystemTestCase
  setup do
    @checkout_log = checkout_logs(:one)
  end

  test "visiting the index" do
    visit checkout_logs_url
    assert_selector "h1", text: "Checkout Logs"
  end

  test "creating a Checkout log" do
    visit checkout_logs_url
    click_on "New Checkout Log"

    fill_in "Bookid", with: @checkout_log.BookId
    fill_in "Checkoutdate", with: @checkout_log.CheckoutDate
    fill_in "Duedate", with: @checkout_log.DueDate
    fill_in "Returneddate", with: @checkout_log.ReturnedDate
    fill_in "Userid", with: @checkout_log.UserId
    fill_in "Book", with: @checkout_log.book_id
    fill_in "User", with: @checkout_log.user_id
    click_on "Create Checkout log"

    assert_text "Checkout log was successfully created"
    click_on "Back"
  end

  test "updating a Checkout log" do
    visit checkout_logs_url
    click_on "Edit", match: :first

    fill_in "Bookid", with: @checkout_log.BookId
    fill_in "Checkoutdate", with: @checkout_log.CheckoutDate
    fill_in "Duedate", with: @checkout_log.DueDate
    fill_in "Returneddate", with: @checkout_log.ReturnedDate
    fill_in "Userid", with: @checkout_log.UserId
    fill_in "Book", with: @checkout_log.book_id
    fill_in "User", with: @checkout_log.user_id
    click_on "Update Checkout log"

    assert_text "Checkout log was successfully updated"
    click_on "Back"
  end

  test "destroying a Checkout log" do
    visit checkout_logs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Checkout log was successfully destroyed"
  end
end
