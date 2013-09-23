require 'test_helper'

class UcenterControllerTest < ActionController::TestCase
  test "should get suggustion" do
    get :suggustion
    assert_response :success
  end

  test "should get inbox" do
    get :inbox
    assert_response :success
  end

  test "should get comment" do
    get :comment
    assert_response :success
  end

  test "should get settings" do
    get :settings
    assert_response :success
  end

  test "should get change_password" do
    get :change_password
    assert_response :success
  end

  test "should get favorite" do
    get :favorite
    assert_response :success
  end

  test "should get view_history" do
    get :view_history
    assert_response :success
  end

end
