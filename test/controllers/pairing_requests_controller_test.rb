require "test_helper"

class PairingRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get pairing_requests_create_url
    assert_response :success
  end

  test "should get destroy" do
    get pairing_requests_destroy_url
    assert_response :success
  end
end
