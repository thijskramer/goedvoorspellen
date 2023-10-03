require 'test_helper'

class MatchesControllerTest < ActionController::TestCase
  setup do
    @match = matches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:matches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create match" do
    assert_difference('Match.count') do
      post :create, match: { awayPlaceholder: @match.awayPlaceholder, awayScore: @match.awayScore, awayteam_id: @match.awayteam_id, homePlaceholder: @match.homePlaceholder, homeScore: @match.homeScore, hometeam_id: @match.hometeam_id, matchtype_id: @match.matchtype_id, number: @match.number, referee_id: @match.referee_id, stadium_id: @match.stadium_id, startDate: @match.startDate, startDateUtcOffset: @match.startDateUtcOffset }
    end

    assert_redirected_to match_path(assigns(:match))
  end

  test "should show match" do
    get :show, id: @match
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @match
    assert_response :success
  end

  test "should update match" do
    patch :update, id: @match, match: { awayPlaceholder: @match.awayPlaceholder, awayScore: @match.awayScore, awayteam_id: @match.awayteam_id, homePlaceholder: @match.homePlaceholder, homeScore: @match.homeScore, hometeam_id: @match.hometeam_id, matchtype_id: @match.matchtype_id, number: @match.number, referee_id: @match.referee_id, stadium_id: @match.stadium_id, startDate: @match.startDate, startDateUtcOffset: @match.startDateUtcOffset }
    assert_redirected_to match_path(assigns(:match))
  end

  test "should destroy match" do
    assert_difference('Match.count', -1) do
      delete :destroy, id: @match
    end

    assert_redirected_to matches_path
  end
end
