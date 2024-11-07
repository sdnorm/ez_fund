require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new_sign_up" do
    get registrations_new_sign_up_url
    assert_response :success
  end
end
