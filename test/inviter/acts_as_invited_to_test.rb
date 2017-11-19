require 'test_helper'

class ActsAsInvitedToTest < ActiveSupport::TestCase
  Rails.application.eager_load!

  test "should return InvitedTo classes" do
    assert_includes(Inviter::ActsAsInvitedTo.invited_tos, Party)
  end

  test "should return Invitation::ActiveRecord_Associations_CollectionProxy" do
    assert(Party.new.invitations.class.name,
           'Invitation::ActiveRecord_Associations_CollectionProxy')
  end
end
