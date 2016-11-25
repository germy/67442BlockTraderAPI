require 'test_helper'

class BidHistoriesControllerTest < ActionController::TestCase
  setup do
    @bid_history = bid_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bid_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bid_history" do
    assert_difference('BidHistory.count') do
      post :create, bid_history: { order_id: @bid_history.order_id, price: @bid_history.price, user_id: @bid_history.user_id }
    end

    assert_redirected_to bid_history_path(assigns(:bid_history))
  end

  test "should show bid_history" do
    get :show, id: @bid_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bid_history
    assert_response :success
  end

  test "should update bid_history" do
    patch :update, id: @bid_history, bid_history: { order_id: @bid_history.order_id, price: @bid_history.price, user_id: @bid_history.user_id }
    assert_redirected_to bid_history_path(assigns(:bid_history))
  end

  test "should destroy bid_history" do
    assert_difference('BidHistory.count', -1) do
      delete :destroy, id: @bid_history
    end

    assert_redirected_to bid_histories_path
  end
end
