class Invitation < ActiveRecord::Base
  belongs_to :inviter, polymorphic: true
  belongs_to :invitee, polymorphic: true
  belongs_to :invited_to, polymorphic: true

  after_create :trigger_callbacks

  private

  def call_back_method
    Inviter::InvitationCallbacks.invitation_created_callback(inviter, invitee, invited_to)
  end

  def trigger_callbacks
    inviters = Inviter::ActsAsInviter.inviters
    invitees = Inviter::ActsAsInvitee.invitees
    invitations = Inviter::ActsAsInvitation.invitations
    [inviters, invitees, invitations].each do |klass|
      _call_back_method = call_back_method
      klass.each do |_klass|
        _klass.send(_call_back_method, self) if _klass.respond_to?(_call_back_method)
      end
    end
  end
end
