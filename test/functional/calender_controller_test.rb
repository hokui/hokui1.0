require 'test_helper'

class CalenderControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
