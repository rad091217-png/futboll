require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get root_path
    assert_response :success
    assert_select "title", "ヨーロッパサッカー掲示板"
  end

  test "should get liga_index" do
    get liga_path
    assert_response :success
    assert_select "title", "ラ・リーガ"
  end

  test "should get bundesu_index" do
    get bundesu_path
    assert_response :success
    assert_select "title", "ブンデスリーガ"
  end

  test "should get premier_index" do
    get premier_path
    assert_response :success
    assert_select "title", "プレミアリーグ"
  end

  test "should get serie_index" do
    get serie_path
    assert_response :success
    assert_select "title", "セリエA"
  end

  test "should get league_one_index" do
    get league_one_path
    assert_response :success
    assert_select "title", "リーグアン"
  end

  test "should get premera_index" do
    get premera_path
    assert_response :success
    assert_select "title", "プリメーラリーガ"
  end

  test "should get euro_index" do
    get euro_path
    assert_response :success
    assert_select "title", "UEFAユーロ"
  end

  test "should get nations_league_index" do
    get nations_league_path
    assert_response :success
    assert_select "title", "ネーションズリーグ"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "要望、お問い合わせ"
  end
end
