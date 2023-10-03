require 'test_helper'

class BookingsControllerTest < ActionController::TestCase
  setup do
    @booking = bookings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create booking" do
    assert_difference('Booking.count') do
      post :create, booking: { is_red_card: @booking.is_red_card, is_yellow_card: @booking.is_yellow_card, match_id: @booking.match_id, minute: @booking.minute, player_id: @booking.player_id, plus_extra_time: @booking.plus_extra_time }
    end

    assert_redirected_to booking_path(assigns(:booking))
  end

  test "should show booking" do
    get :show, id: @booking
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @booking
    assert_response :success
  end

  test "should update booking" do
    patch :update, id: @booking, booking: { is_red_card: @booking.is_red_card, is_yellow_card: @booking.is_yellow_card, match_id: @booking.match_id, minute: @booking.minute, player_id: @booking.player_id, plus_extra_time: @booking.plus_extra_time }
    assert_redirected_to booking_path(assigns(:booking))
  end

  test "should destroy booking" do
    assert_difference('Booking.count', -1) do
      delete :destroy, id: @booking
    end

    assert_redirected_to bookings_path
  end
end
