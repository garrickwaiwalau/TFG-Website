require "test_helper"

class ServiceControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get service_new_url
    assert_response :success
  end
end
