require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  setup do
    @customer = customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post :create, customer: { billing_address: @customer.billing_address, business_name: @customer.business_name, city: @customer.city, contact_id: @customer.contact_id, country_id: @customer.country_id, phone: @customer.phone, state_id: @customer.state_id, street_address: @customer.street_address, suit_unit: @customer.suit_unit, website: @customer.website, zip_code: @customer.zip_code }
    end

    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should show customer" do
    get :show, id: @customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer
    assert_response :success
  end

  test "should update customer" do
    patch :update, id: @customer, customer: { billing_address: @customer.billing_address, business_name: @customer.business_name, city: @customer.city, contact_id: @customer.contact_id, country_id: @customer.country_id, phone: @customer.phone, state_id: @customer.state_id, street_address: @customer.street_address, suit_unit: @customer.suit_unit, website: @customer.website, zip_code: @customer.zip_code }
    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete :destroy, id: @customer
    end

    assert_redirected_to customers_path
  end
end
