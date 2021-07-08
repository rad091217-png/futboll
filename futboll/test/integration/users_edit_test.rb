require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:kehlar)
  end

  test "unsuccessful edit" do
    login_as(@user)
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { name: "kou",
                                             email: "kou@example",
                                             password: "kou",
                                             password_confirmation: "k" } }

    assert_template "users/edit"
    assert_select "div.alert", "The form contains 4 errors."
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    assert_equal session[:forwarding_url], edit_user_url(@user)
    login_as(@user)
    assert_nil session[:forwarding_url]
    assert_redirected_to edit_user_url(@user)
    name = "kouei"
    email = "rad@gmail.com"
    patch user_path(@user), params: { user: { name: name,
                                             email: email,
                                             password: "",
                                             password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
