require 'test_helper'

class TourDeFrancesControllerTest < ActionController::TestCase
  setup do
    @tour_de_france = tour_de_frances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tour_de_frances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tour_de_france" do
    assert_difference('TourDeFrance.count') do
      post :create, tour_de_france: { description: @tour_de_france.description, year: @tour_de_france.year }
    end

    assert_redirected_to tour_de_france_path(assigns(:tour_de_france))
  end

  test "should show tour_de_france" do
    get :show, id: @tour_de_france
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tour_de_france
    assert_response :success
  end

  test "should update tour_de_france" do
    patch :update, id: @tour_de_france, tour_de_france: { description: @tour_de_france.description, year: @tour_de_france.year }
    assert_redirected_to tour_de_france_path(assigns(:tour_de_france))
  end

  test "should destroy tour_de_france" do
    assert_difference('TourDeFrance.count', -1) do
      delete :destroy, id: @tour_de_france
    end

    assert_redirected_to tour_de_frances_path
  end
end
