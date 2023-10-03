require 'test_helper'

class MatchTypesControllerTest < ActionController::TestCase
  setup do
    @match_type = match_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:match_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create match_type" do
    assert_difference('MatchType.count') do
      post :create, match_type: { name: @match_type.name }
    end

    assert_redirected_to match_type_path(assigns(:match_type))
  end

  test "should show match_type" do
    get :show, id: @match_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @match_type
    assert_response :success
  end

  test "should update match_type" do
    patch :update, id: @match_type, match_type: { name: @match_type.name }
    assert_redirected_to match_type_path(assigns(:match_type))
  end

  test "should destroy match_type" do
    assert_difference('MatchType.count', -1) do
      delete :destroy, id: @match_type
    end

    assert_redirected_to match_types_path
  end
end
