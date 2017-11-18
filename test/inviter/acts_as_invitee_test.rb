require 'test_helper'

class ActsAsInviteeTest < ActiveSupport::TestCase
  Rails.application.eager_load!

  test "should return invitee classes" do
    assert_includes(Inviter::ActsAsInvitee.invitees, User)
  end
end
