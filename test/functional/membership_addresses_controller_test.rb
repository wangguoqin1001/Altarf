require 'test_helper'

class MembershipAddressesControllerTest < ActionController::TestCase
  setup do
    @membership_address = membership_addresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:membership_addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create membership_address" do
    assert_difference('MembershipAddress.count') do
      post :create, membership_address: { addr: @membership_address.addr, city: @membership_address.city, district: @membership_address.district, membership_id: @membership_address.membership_id, mobile: @membership_address.mobile, phone: @membership_address.phone, postal: @membership_address.postal, province: @membership_address.province, username: @membership_address.username }
    end

    assert_redirected_to membership_address_path(assigns(:membership_address))
  end

  test "should show membership_address" do
    get :show, id: @membership_address
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @membership_address
    assert_response :success
  end

  test "should update membership_address" do
    put :update, id: @membership_address, membership_address: { addr: @membership_address.addr, city: @membership_address.city, district: @membership_address.district, membership_id: @membership_address.membership_id, mobile: @membership_address.mobile, phone: @membership_address.phone, postal: @membership_address.postal, province: @membership_address.province, username: @membership_address.username }
    assert_redirected_to membership_address_path(assigns(:membership_address))
  end

  test "should destroy membership_address" do
    assert_difference('MembershipAddress.count', -1) do
      delete :destroy, id: @membership_address
    end

    assert_redirected_to membership_addresses_path
  end
end
