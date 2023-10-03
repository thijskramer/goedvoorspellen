require 'test_helper'

class WorldcupsControllerTest < ActionController::TestCase
  setup do
    @worldcup = worldcups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:worldcups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create worldcup" do
    assert_difference('Worldcup.count') do
      post :create, worldcup: { location: @worldcup.location, year: @worldcup.year }
    end

    assert_redirected_to worldcup_path(assigns(:worldcup))
  end

  test "should show worldcup" do
    get :show, id: @worldcup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @worldcup
    assert_response :success
  end

  test "should update worldcup" do
    patch :update, id: @worldcup, worldcup: { location: @worldcup.location, year: @worldcup.year }
    assert_redirected_to worldcup_path(assigns(:worldcup))
  end

  test "should destroy worldcup" do
    assert_difference('Worldcup.count', -1) do
      delete :destroy, id: @worldcup
    end

    assert_redirected_to worldcups_path
  end
end
