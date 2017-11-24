require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  Rails.application.eager_load!

  setup do
    @inviter = users(:inviter)
    @invitee = users(:invitee)
    @invited_to = parties(:my_house)
  end

  test "invitation record returns associations" do
    invitation = @inviter.send_invitation(@invitee, @invited_to)
    assert_equal(invitation.inviter, @inviter)
    assert_equal(invitation.invitee, @invitee)
    assert_equal(invitation.invited_to, @invited_to)
  end

  test "returns true if accepted" do
    invitation = @inviter.send_invitation(@invitee, @invited_to)
    assert_equal(invitation.accepted?, false)
    invitation.accept
    assert_equal(invitation.accepted?, true)
  end


  test ".reset resets accepted timestamps" do
    invitation = @inviter.send_invitation(@invitee, @invited_to)
    assert_equal(invitation.accepted?, false)
    invitation.accept
    assert_equal(invitation.accepted?, true)
    invitation.reset
    assert_equal(invitation.accepted?, false)
  end

  test "returns true if declined" do
    invitation = @inviter.send_invitation(@invitee, @invited_to)
    assert_equal(invitation.declined?, false)
    invitation.decline
    assert_equal(invitation.declined?, true)
  end

  test ".reset resets declined timestamps" do
    invitation = @inviter.send_invitation(@invitee, @invited_to)
    assert_equal(invitation.declined?, false)
    invitation.decline
    assert_equal(invitation.declined?, true)
    invitation.reset
    assert_equal(invitation.declined?, false)
  end

  test ".accepted_or_declined returns accepted? || declined?" do
    invitation = @inviter.send_invitation(@invitee, @invited_to)
    assert_equal(invitation.accepted_or_declined?, false)
    invitation.decline
    assert_equal(invitation.accepted_or_declined?, true)
    invitation.reset
    assert_equal(invitation.accepted_or_declined?, false)
    invitation.decline
    assert_equal(invitation.accepted_or_declined?, true)
  end

  setup do
    User.instance_variable_set(:@_callbacks, [])
    Party.instance_variable_set(:@_callbacks, [])
    [User, Party].each do |klass|
      klass.define_singleton_method(:user_invited_user_to_party) { |invitation| @_callbacks << :create }
      klass.define_singleton_method(:user_accepted_invite_from_user_to_party) { |invitation| @_callbacks << :accept }
      klass.define_singleton_method(:user_declined_invite_from_user_to_party) { |invitation|  @_callbacks << :decline }
      klass.define_singleton_method(:user_reset_invite_from_user_to_party) { |invitation| @_callbacks << :reset }
    end
  end

  test "runs callbacks for created methods" do
    @inviter.send_invitation(@invitee, @invited_to)
    assert_equal(User.instance_variable_get(:@_callbacks), [:create])
    assert_equal(Party.instance_variable_get(:@_callbacks), [:create])
  end

  test "runs callbacks for invitation accepted" do
    invitation = @inviter.send_invitation(@invitee, @invited_to)
    invitation.accept
    assert_equal(User.instance_variable_get(:@_callbacks), [:create, :accept])
    assert_equal(Party.instance_variable_get(:@_callbacks), [:create, :accept])
  end

  test "runs callbacks for invitation declined" do
    invitation = @inviter.send_invitation(@invitee, @invited_to)
    invitation.decline
    assert_equal(User.instance_variable_get(:@_callbacks), [:create, :decline])
    assert_equal(Party.instance_variable_get(:@_callbacks), [:create, :decline])
  end

  test "runs callbacks for invitation reset" do
    invitation = @inviter.send_invitation(@invitee, @invited_to)
    invitation.accept
    invitation.reset
    assert_equal(User.instance_variable_get(:@_callbacks), [:create, :accept, :reset])
    assert_equal(Party.instance_variable_get(:@_callbacks), [:create, :accept, :reset])
  end

  test "fails uniqueness validation" do
    invite = @inviter.send_invitation(@invitee, @invited_to)
    repeated_invite = @inviter.send_invitation(@invitee, @invited_to)
    assert(invite.persisted?)
    assert(!repeated_invite.persisted?)
    assert_equal(repeated_invite.errors.messages, { inviter_id: ['invitation already exists'] })
  end
end
