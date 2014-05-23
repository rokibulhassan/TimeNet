require 'test_helper'

class RequestInfosControllerTest < ActionController::TestCase
  setup do
    @request_info = request_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:request_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create request_info" do
    assert_difference('RequestInfo.count') do
      post :create, request_info: { comments: @request_info.comments, email: @request_info.email, first_name: @request_info.first_name, last_name: @request_info.last_name, query: @request_info.query }
    end

    assert_redirected_to request_info_path(assigns(:request_info))
  end

  test "should show request_info" do
    get :show, id: @request_info
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @request_info
    assert_response :success
  end

  test "should update request_info" do
    patch :update, id: @request_info, request_info: { comments: @request_info.comments, email: @request_info.email, first_name: @request_info.first_name, last_name: @request_info.last_name, query: @request_info.query }
    assert_redirected_to request_info_path(assigns(:request_info))
  end

  test "should destroy request_info" do
    assert_difference('RequestInfo.count', -1) do
      delete :destroy, id: @request_info
    end

    assert_redirected_to request_infos_path
  end
end
