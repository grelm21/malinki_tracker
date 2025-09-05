require "test_helper"

class ClassroomsStudentsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get classrooms_students_update_url
    assert_response :success
  end
end
