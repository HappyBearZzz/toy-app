require 'test_helper'

class ActivitiesControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @user.id = 1
    @user.save
    @activity = activities(:one)
    @activity.user_id = @user.id
    # @activity.user = @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:activities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  


  test "should create activity" do
    assert_difference('Activity.count') do
      post :create, activity: { category: @activity.category, content: @activity.content, end_at: @activity.end_at, location: @activity.location, start_at: @activity.start_at, title: @activity.title, user_id: @activity.user_id }
    end

    assert_redirected_to activity_path(assigns(:activity))
  end

  test "should show activity" do
    get :show, id: @activity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @activity
    assert_response :success
  end

  test "should update activity" do
    patch :update, id: @activity, activity: { category: @activity.category, content: @activity.content, end_at: @activity.end_at, location: @activity.location, start_at: @activity.start_at, title: @activity.title, user_id: @activity.user_id }
    assert_redirected_to activity_path(assigns(:activity))
  end

  test "should destroy activity" do
    assert_difference('Activity.count', -1) do
      delete :destroy, id: @activity
    end

    assert_redirected_to activities_path
  end
end
