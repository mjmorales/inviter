require 'test_helper'

class InvitationCallbacksTest < ActiveSupport::TestCase
  Rails.application.eager_load!

  test "should return method string for invitation creeated" do
    inviter = users(:inviter)
    invitee = users(:invitee)
    invited_to = parties(:my_house)
    subject = Inviter::InvitationCallbacks.invitation_created_callback(inviter, invitee, invited_to)
    assert(subject, :user_invited_user_to_party)
  end
end
