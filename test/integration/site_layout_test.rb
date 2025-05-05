require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bobby)
  end

  test "layout links when user is not logged in" do
    # home page
    get root_path
    assert_template "static_pages/home"
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", about_path

    # test if full title function returns correct title
    get contact_path
    assert_select "title", full_title("Contact")

    # test if signup page returns correct title 
    get signup_path
    assert_select "title", full_title("Sign up")

    get login_path
    assert_template "sessions/new"
    assert_not is_logged_in?    
  end

  test "layout links when user is logged in" do
    log_in_as(@user)
    # home page
    get root_path
    assert_template "static_pages/home"
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", login_path, count: 0

    # test if full title function returns correct title
    get contact_path
    assert_select "title", full_title("Contact")

    # test if signup page returns correct title 
    get signup_path
    assert_select "title", full_title("Sign up")

    get login_path
    assert_template "sessions/new"
    assert is_logged_in?    
  end

end
