class Invitation < ActiveRecord::Base
  belongs_to :inviter, polymorphic: true
  belongs_to :invitee, polymorphic: true
  belongs_to :invited_to, polymorphic: true

  alias_attribute :accepted?, :accepted_at?
  alias_attribute :declined?, :declined_at?

  validates_uniqueness_of :inviter_id,
                          scope: [:inviter_type, :invitee_type, :invitee_id, :invited_to_type,
                                  :invited_to_id],
                          message: 'invitation already exists'

  after_save :trigger_callbacks, if: :valid_callback?

  def accepted_or_declined?
    accepted? || declined?
  end

  def accept
    update(accepted_at: Time.current) unless accepted_or_declined?
  end

  def decline
    update(declined_at: Time.current) unless accepted_or_declined?
  end

  def reset
    update(accepted_at: nil, declined_at: nil)
  end

  private

  [:accepted, :declined, :created].each do |action|
    define_method("invitation_#{action}?") { eval("saved_change_to_#{action}_at?") }
  end

  def valid_callback?
    invitation_created? || invitation_accepted? || invitation_declined?
  end

  def invitation_reset?
    return true unless declined? || accepted?
    false
  end

  def callback_type
    return 'created' if invitation_created?
    return 'reset' if invitation_reset?
    return 'declined' if invitation_declined?
    'accepted'
  end

  def call_back_method
    callback_args = [inviter, invitee, invited_to]
    current_callback = "invitation_#{callback_type}_callback"
    Inviter::InvitationCallbacks.send(current_callback, *callback_args)
  end

  def trigger_callbacks
    inviters = Inviter::ActsAsInviter.inviters
    invitees = Inviter::ActsAsInvitee.invitees
    invited_tos = Inviter::ActsAsInvitedTo.invited_tos
    listeners = inviters | invitees | invited_tos

    return unless listeners
    listeners.each do |klass|
      _call_back_method = call_back_method
      klass.send(_call_back_method, self) if klass.respond_to?(_call_back_method)
    end
  end
end
