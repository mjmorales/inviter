class Invitation < ActiveRecord::Base
  belongs_to :inviter, polymorphic: true
  belongs_to :invitee, polymorphic: true
  belongs_to :invited_to, polymorphic: true

  alias_attribute :accepted?, :accepted_at?
  alias_attribute :declined?, :declined_at?

  after_create :trigger_callbacks

  def accepted_or_declined?
    accepted_at || declined_at
  end

  def accept
    update!(accepted_at: Time.current) unless accepted_or_declined?
  end

  def decline
    update!(declined_at: Time.current) unless accepted_or_declined?
  end

  def reset
    update!(accepted_at: nil, declined_at: nil)
  end

  private

  def call_back_method
    Inviter::InvitationCallbacks.invitation_created_callback(inviter, invitee, invited_to)
  end

  def trigger_callbacks
    inviters = Inviter::ActsAsInviter.inviters
    invitees = Inviter::ActsAsInvitee.invitees
    invitations = Inviter::ActsAsInvitation.invitations
    (inviters | invitees | invitations).each do |klass|
      _call_back_method = call_back_method
      klass.send(_call_back_method, self) if klass.respond_to?(_call_back_method)
    end
  end
end
