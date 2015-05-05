require 'test_helper'

class PlayerSessionTimesControllerControllerTest < ActionController::TestCase
  test "should get request_sub" do
    get :request_sub
    assert_response :success
  end

end
