require "test_helper"

class TrackingControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get tracking_new_url
    assert_response :success
  end
end
