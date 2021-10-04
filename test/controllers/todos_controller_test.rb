require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get todos_home_url
    assert_response :success
  end
end
