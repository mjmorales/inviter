require 'test_helper'

class ActsAsInvitationTest < ActiveSupport::TestCase
  Rails.application.eager_load!

  test "should return invitation classes" do
    assert_includes(Inviter::ActsAsInvitation.invitations, Party)
  end

  test "should return Invitation::ActiveRecord_Associations_CollectionProxy" do
    assert(Party.new.invitations.class.name,
           'Invitation::ActiveRecord_Associations_CollectionProxy')
  end
end
