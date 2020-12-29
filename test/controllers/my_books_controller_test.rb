require 'test_helper'

class MyBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_books_index_url
    assert_response :success
  end

  test "should get new" do
    get my_books_new_url
    assert_response :success
  end

  test "should get update" do
    get my_books_update_url
    assert_response :success
  end

end
