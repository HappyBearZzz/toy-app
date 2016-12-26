require 'test_helper'

class ChatinfosControllerTest < ActionController::TestCase
  setup do
    @chatinfo = chatinfos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chatinfos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chatinfo" do
    assert_difference('Chatinfo.count') do
      post :create, chatinfo: { activity_id: @chatinfo.activity_id, content: @chatinfo.content, user_id: @chatinfo.user_id }
    end

    assert_redirected_to chatinfo_path(assigns(:chatinfo))
  end

  test "should show chatinfo" do
    get :show, id: @chatinfo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chatinfo
    assert_response :success
  end

  test "should update chatinfo" do
    patch :update, id: @chatinfo, chatinfo: { activity_id: @chatinfo.activity_id, content: @chatinfo.content, user_id: @chatinfo.user_id }
    assert_redirected_to chatinfo_path(assigns(:chatinfo))
  end

  test "should destroy chatinfo" do
    assert_difference('Chatinfo.count', -1) do
      delete :destroy, id: @chatinfo
    end

    assert_redirected_to chatinfos_path
  end
end
