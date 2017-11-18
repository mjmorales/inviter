require 'test_helper'

class ActsAsInvitationTest < ActiveSupport::TestCase
  Rails.application.eager_load!

  test "should return invitation classes" do
    assert_includes(Inviter::ActsAsInvitation.invitations, Party)
  end
end
