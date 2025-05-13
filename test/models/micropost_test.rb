require "test_helper"

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:bobby)
    @micropost = @user.microposts.build(content: "test micropost")
  end

  test "micropost should be valid" do
    assert @micropost.valid?
  end

  test "user_id should be valid" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "should be false when content is blank" do
    @micropost.content = " "
    assert_not @micropost.valid?
  end

  test "should be false when content exceed 140" do
    @micropost.content = "1" * 141
    assert_not @micropost.valid?
  end

  test "the order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end

end

