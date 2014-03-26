require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
  setup do
    @address = addresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create address" do
    assert_difference('Address.count') do
      post :create, address: { addr: @address.addr, city: @address.city, district: @address.district, membership_id: @address.membership_id, mobile: @address.mobile, phone: @address.phone, postal: @address.postal, province: @address.province, username: @address.username }
    end

    assert_redirected_to address_path(assigns(:address))
  end

  test "should show address" do
    get :show, id: @address
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @address
    assert_response :success
  end

  test "should update address" do
    put :update, id: @address, address: { addr: @address.addr, city: @address.city, district: @address.district, membership_id: @address.membership_id, mobile: @address.mobile, phone: @address.phone, postal: @address.postal, province: @address.province, username: @address.username }
    assert_redirected_to address_path(assigns(:address))
  end

  test "should destroy address" do
    assert_difference('Address.count', -1) do
      delete :destroy, id: @address
    end

    assert_redirected_to addresses_path
  end
end
