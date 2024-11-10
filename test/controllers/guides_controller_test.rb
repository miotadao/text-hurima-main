require "test_helper"

class GuidesControllerTest < ActionDispatch::IntegrationTest
  test "should get guide" do
    get guides_guide_url
    assert_response :success
  end
end
