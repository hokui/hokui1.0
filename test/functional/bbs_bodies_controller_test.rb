require 'test_helper'

class BbsBodiesControllerTest < ActionController::TestCase
  setup do
    @bbs_body = bbs_bodies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bbs_bodies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bbs_body" do
    assert_difference('BbsBody.count') do
      post :create, bbs_body: @bbs_body.attributes
    end

    assert_redirected_to bbs_body_path(assigns(:bbs_body))
  end

  test "should show bbs_body" do
    get :show, id: @bbs_body.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bbs_body.to_param
    assert_response :success
  end

  test "should update bbs_body" do
    put :update, id: @bbs_body.to_param, bbs_body: @bbs_body.attributes
    assert_redirected_to bbs_body_path(assigns(:bbs_body))
  end

  test "should destroy bbs_body" do
    assert_difference('BbsBody.count', -1) do
      delete :destroy, id: @bbs_body.to_param
    end

    assert_redirected_to bbs_bodies_path
  end
end
