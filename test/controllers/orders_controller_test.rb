require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { address: @order.address, customer_id: @order.customer_id, delivery_status: @order.delivery_status, food_order_id: @order.food_order_id, latitude: @order.latitude, longitude: @order.longitude, payment_id_receiever: @order.payment_id_receiever, payment_id_user: @order.payment_id_user, provider_id: @order.provider_id }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { address: @order.address, customer_id: @order.customer_id, delivery_status: @order.delivery_status, food_order_id: @order.food_order_id, latitude: @order.latitude, longitude: @order.longitude, payment_id_receiever: @order.payment_id_receiever, payment_id_user: @order.payment_id_user, provider_id: @order.provider_id }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
