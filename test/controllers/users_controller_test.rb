require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @create_attributes = {
      :name=>"sam",
      :password=>"private",
      :password_confirmation=>"private"
    }
    @change_password_attributes = {
      :old_password=>"secret",
      :password=>"private",
      :password_confirmation=>"private"
    }
    @update_attributes = {
      :name=>"sam",
      :sex=>"Female",
      :description=>"private"
    }
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      #post :create, user: { age: @user.age, college: @user.college, description: @user.description, hashed_password: @user.hashed_password, major: @user.major, name: @user.name, no: @user.no, salt: @user.salt, school_year: @user.school_year, sex: @user.sex }
      post :create, :user => @create_attributes
    end

    #assert_redirected_to user_path(assigns(:user))
    assert_redirected_to home_path
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    #patch :update, id: @user, user: { age: @user.age, college: @user.college, description: @user.description, hashed_password: @user.hashed_password, major: @user.major, name: @user.name, no: @user.no, salt: @user.salt, school_year: @user.school_year, sex: @user.sex }
    #assert_redirected_to user_path(assigns(:user))
    patch :update, id: @user, :user=>@update_attributes
    assert_redirected_to home_url
  end
  
  test "should update user password" do
    dave = users(:one)
    session[:user_id] = dave.id
    # post :update_password, id: @user, :user=>@change_password_attributes
    post :update_password,:old_password=>"secret",:password=>"private",:password_confirmation=>"private"
    assert_redirected_to login_path
  end
  
  test "should fail update user password" do
    dave = users(:one)
    session[:user_id] = dave.id
    post :update_password,:old_password=>"wrong",:password=>"private",:password_confirmation=>"private"
    assert_redirected_to change_password_path
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
  
  test "should login" do
    dave = users(:one)
    post :login_confirm,:name=>dave.name,:password=>'secret'
    assert_redirected_to home_url
    assert_equal dave.id,session[:user_id]
  end
  
  test "should fail login" do
    dave = users(:one)
    post :login_confirm,:name=>dave.name,:password=>'wrong'
    assert_redirected_to login_url
  end

  test "should logout" do
    delete :logout
    assert_redirected_to login_url
  end
end
