require 'test_helper'

class AdminsControllerTest < ActionController::TestCase
  setup do
    @create_attributes = {
      :name=>"sam",
      :password=>"private",
      :password_confirmation=>"private"
    }
    @update_attributes = {
      :name=>"secret",
      :password=>"private",
      :password_confirmation=>"private"
    }
    @admin = admins(:one)
    @admin_two = admins(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin" do
    assert_difference('Admin.count') do
      #post :create, admin: { hashed_password: @admin.hashed_password, name: @admin.name, salt: @admin.salt }
      post :create, :admin => @create_attributes
    end

    # assert_redirected_to admin_path(assigns(:admin))
    assert_redirected_to admins_path
  end

  test "should show admin" do
    get :show, id: @admin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin
    assert_response :success
  end

  test "should update admin" do
    # patch :update, id: @admin, admin: { hashed_password: @admin.hashed_password, name: @admin.name, salt: @admin.salt }
    # assert_redirected_to admin_path(assigns(:admin))
    patch :update, id: @admin, :admin=>@update_attributes
    assert_redirected_to admins_url
  end

  test "should destroy admin" do
    assert_difference('Admin.count', -1) do
      delete :destroy, id: @admin_two
    end

    assert_redirected_to admins_path
  end
end
