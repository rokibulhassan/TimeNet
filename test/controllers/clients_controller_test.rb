require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  setup do
    @client = clients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client" do
    assert_difference('Client.count') do
      post :create, client: { billing_address: @client.billing_address, business_name: @client.business_name, city: @client.city, country_id: @client.country_id, phone: @client.phone, state_id: @client.state_id, street_address: @client.street_address, suit_unit: @client.suit_unit, user_id: @client.user_id, website: @client.website, zip_code: @client.zip_code }
    end

    assert_redirected_to client_path(assigns(:client))
  end

  test "should show client" do
    get :show, id: @client
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client
    assert_response :success
  end

  test "should update client" do
    patch :update, id: @client, client: { billing_address: @client.billing_address, business_name: @client.business_name, city: @client.city, country_id: @client.country_id, phone: @client.phone, state_id: @client.state_id, street_address: @client.street_address, suit_unit: @client.suit_unit, user_id: @client.user_id, website: @client.website, zip_code: @client.zip_code }
    assert_redirected_to client_path(assigns(:client))
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete :destroy, id: @client
    end

    assert_redirected_to clients_path
  end
end
