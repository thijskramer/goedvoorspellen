require 'test_helper'

class SubstitutesControllerTest < ActionController::TestCase
  setup do
    @substitute = substitutes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:substitutes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create substitute" do
    assert_difference('Substitute.count') do
      post :create, substitute: { match_id: @substitute.match_id, minute: @substitute.minute, player_in_id: @substitute.player_in_id, player_out_id: @substitute.player_out_id, plus_extra_time: @substitute.plus_extra_time }
    end

    assert_redirected_to substitute_path(assigns(:substitute))
  end

  test "should show substitute" do
    get :show, id: @substitute
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @substitute
    assert_response :success
  end

  test "should update substitute" do
    patch :update, id: @substitute, substitute: { match_id: @substitute.match_id, minute: @substitute.minute, player_in_id: @substitute.player_in_id, player_out_id: @substitute.player_out_id, plus_extra_time: @substitute.plus_extra_time }
    assert_redirected_to substitute_path(assigns(:substitute))
  end

  test "should destroy substitute" do
    assert_difference('Substitute.count', -1) do
      delete :destroy, id: @substitute
    end

    assert_redirected_to substitutes_path
  end
end
