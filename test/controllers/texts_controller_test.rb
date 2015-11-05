require 'test_helper'

class TextsControllerTest < ActionController::TestCase
  test "should get setup" do
    get :setup
    assert_response :success
  end

end
