require 'test_helper'

class CheckoutLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @checkout_log = checkout_logs(:one)
  end

  test "should get index" do
    get checkout_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_checkout_log_url
    assert_response :success
  end

  test "should create checkout_log" do
    assert_difference('CheckoutLog.count') do
      post checkout_logs_url, params: { checkout_log: { BookId: @checkout_log.BookId, checkout_date: @checkout_log.checkout_date, due_date: @checkout_log.due_date, returned_date: @checkout_log.returned_date, UserId: @checkout_log.UserId, book_id: @checkout_log.book_id, user_id: @checkout_log.user_id } }
    end

    assert_redirected_to checkout_log_url(CheckoutLog.last)
  end

  test "should show checkout_log" do
    get checkout_log_url(@checkout_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_checkout_log_url(@checkout_log)
    assert_response :success
  end

  test "should update checkout_log" do
    patch checkout_log_url(@checkout_log), params: { checkout_log: { BookId: @checkout_log.BookId, checkout_date: @checkout_log.checkout_date, due_date: @checkout_log.due_date, returned_date: @checkout_log.returned_date, UserId: @checkout_log.UserId, book_id: @checkout_log.book_id, user_id: @checkout_log.user_id } }
    assert_redirected_to checkout_log_url(@checkout_log)
  end

  test "should destroy checkout_log" do
    assert_difference('CheckoutLog.count', -1) do
      delete checkout_log_url(@checkout_log)
    end

    assert_redirected_to checkout_logs_url
  end
end
