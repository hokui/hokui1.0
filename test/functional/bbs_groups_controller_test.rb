require 'test_helper'

class BbsGroupsControllerTest < ActionController::TestCase
  setup do
    @bbs_group = bbs_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bbs_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bbs_group" do
    assert_difference('BbsGroup.count') do
      post :create, bbs_group: @bbs_group.attributes
    end

    assert_redirected_to bbs_group_path(assigns(:bbs_group))
  end

  test "should show bbs_group" do
    get :show, id: @bbs_group.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bbs_group.to_param
    assert_response :success
  end

  test "should update bbs_group" do
    put :update, id: @bbs_group.to_param, bbs_group: @bbs_group.attributes
    assert_redirected_to bbs_group_path(assigns(:bbs_group))
  end

  test "should destroy bbs_group" do
    assert_difference('BbsGroup.count', -1) do
      delete :destroy, id: @bbs_group.to_param
    end

    assert_redirected_to bbs_groups_path
  end
end
