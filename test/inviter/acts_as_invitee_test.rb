require 'test_helper'

class ActsAsInviteeTest < ActiveSupport::TestCase
  Rails.application.eager_load!

  test "should return invitee classes" do
    assert_includes(Inviter::ActsAsInvitee.invitees, User)
  end

  test "should return Invitation::ActiveRecord_Associations_CollectionProxy" do
    assert(User.new.invitations.class.name,
           'Invitation::ActiveRecord_Associations_CollectionProxy')
  end
end
