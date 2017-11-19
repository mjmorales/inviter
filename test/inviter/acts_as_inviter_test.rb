require 'test_helper'

class ActsAsInviterTest < ActiveSupport::TestCase
  Rails.application.eager_load!

  inviter = User.create!
  invitee = User.create!
  invited_to = Party.create!

  test "should return inviter classes" do
    assert_includes(Inviter::ActsAsInviter.inviters, User)
  end

  test "should return Invitation::ActiveRecord_Associations_CollectionProxy" do
    assert(User.new.sent_invitations.class.name,
           'Invitation::ActiveRecord_Associations_CollectionProxy')
  end

  test "should send an invitation" do
    inviter.send_invitation(invitee, invited_to)
    assert(inviter.sent_invitations, invitee.invitations)
  end
end
