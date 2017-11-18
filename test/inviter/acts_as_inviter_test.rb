require 'test_helper'

class ActsAsInviterTest < ActiveSupport::TestCase
  Rails.application.eager_load!

  test "should return inviter classes" do
    assert_includes(Inviter::ActsAsInviter.inviters, User)
  end
end
