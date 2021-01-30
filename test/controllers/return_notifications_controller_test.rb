require 'test_helper'

class ReturnNotificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @return_notification = return_notifications(:one)
  end

  test "should get index" do
    get return_notifications_url
    assert_response :success
  end

  test "should get new" do
    get new_return_notification_url
    assert_response :success
  end

  test "should create return_notification" do
    assert_difference('ReturnNotification.count') do
      post return_notifications_url, params: { return_notification: { book_number: @return_notification.book_number, user_id: @return_notification.user_id } }
    end

    assert_redirected_to return_notification_url(ReturnNotification.last)
  end

  test "should show return_notification" do
    get return_notification_url(@return_notification)
    assert_response :success
  end

  test "should get edit" do
    get edit_return_notification_url(@return_notification)
    assert_response :success
  end

  test "should update return_notification" do
    patch return_notification_url(@return_notification), params: { return_notification: { book_number: @return_notification.book_number, user_id: @return_notification.user_id } }
    assert_redirected_to return_notification_url(@return_notification)
  end

  test "should destroy return_notification" do
    assert_difference('ReturnNotification.count', -1) do
      delete return_notification_url(@return_notification)
    end

    assert_redirected_to return_notifications_url
  end
end
