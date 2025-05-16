require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      name: "Example User",
      email: "user@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "name shouldn't be too long"  do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email shouldn't be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid address" do 
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address| 
      @user.email = valid_address
      assert@user.valid?, "#{valid_addresses.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end 

  test "downacasting email address should work" do
    @user.email = "Foo@ExAMPle.CoM"
    @user.save
    assert_equal @user.reload.email,"Foo@ExAMPle.CoM".downcase,  "Email should be downcased"
  end 

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "authenicated? should return false when remember token is nil" do
    assert_not @user.authenticated?(:remember, "")
  end

  test "micropost should be destroyed when user is destroyed" do
    @user.save
    @user.microposts.create!(content: "test micropost")
    assert_difference "Micropost.count", -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    bobby = users(:bobby)
    second  = users(:malory)
    assert_not bobby.following?(second)
    bobby.follow(second)
    assert bobby.following?(second)
    assert second.followers.include?(bobby)
    bobby.unfollow(second)
    assert_not bobby.following?(second)
    assert_not second.followers.include?(bobby)
    # Users can't follow themselves.
    bobby.follow(bobby)
    assert_not bobby.following?(bobby)
  end


  test "feed should have the right posts" do
    bobby = users(:bobby)
    malory  = users(:malory)
    lana    = users(:lana)
    # Posts from followed user
    lana.microposts.each do |post_following|
      assert bobby.feed.include?(post_following)
    end
    bobby.microposts.each do |post_self|
      assert bobby.feed.include?(post_self)
      assert_equal bobby.feed.distinct, bobby.feed
    end
    # Self-posts for user with followers
    bobby.microposts.each do |post_self|
      assert bobby.feed.include?(post_self)
    end
    # Posts from non-followed user
    malory.microposts.each do |post_unfollowed|
      assert_not bobby.feed.include?(post_unfollowed)
    end
  end
end
