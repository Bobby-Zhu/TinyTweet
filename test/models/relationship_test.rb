require "test_helper"

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @user = users(:bobby)
    @other_user = users(:malory)
    @relationship = Relationship.create(follower_id: @user.id,
                                        followed_id: @other_user.id)
  end

  test "should be a valid relationship" do
    assert @relationship.valid?
  end

  test "should have a valid follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should be a valid followed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
