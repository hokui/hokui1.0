require 'test_helper'

class BbsTopicsControllerTest < ActionController::TestCase
  setup do
    @bbs_topic = bbs_topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bbs_topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bbs_topic" do
    assert_difference('BbsTopic.count') do
      post :create, bbs_topic: @bbs_topic.attributes
    end

    assert_redirected_to bbs_topic_path(assigns(:bbs_topic))
  end

  test "should show bbs_topic" do
    get :show, id: @bbs_topic.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bbs_topic.to_param
    assert_response :success
  end

  test "should update bbs_topic" do
    put :update, id: @bbs_topic.to_param, bbs_topic: @bbs_topic.attributes
    assert_redirected_to bbs_topic_path(assigns(:bbs_topic))
  end

  test "should destroy bbs_topic" do
    assert_difference('BbsTopic.count', -1) do
      delete :destroy, id: @bbs_topic.to_param
    end

    assert_redirected_to bbs_topics_path
  end
end
