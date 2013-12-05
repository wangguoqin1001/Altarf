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
      post :create, order: { addr: @order.addr, billing: @order.billing, city: @order.city, coupon: @order.coupon, district: @order.district, invoice_title: @order.invoice_title, mobile: @order.mobile, need_invoice: @order.need_invoice, nickname: @order.nickname, payment: @order.payment, phone: @order.phone, postal: @order.postal, productid: @order.productid, province: @order.province, quantity: @order.quantity, username: @order.username }
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
    put :update, id: @order, order: { addr: @order.addr, billing: @order.billing, city: @order.city, coupon: @order.coupon, district: @order.district, invoice_title: @order.invoice_title, mobile: @order.mobile, need_invoice: @order.need_invoice, nickname: @order.nickname, payment: @order.payment, phone: @order.phone, postal: @order.postal, productid: @order.productid, province: @order.province, quantity: @order.quantity, username: @order.username }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
