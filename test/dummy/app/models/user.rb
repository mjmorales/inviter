class User < ApplicationRecord
  acts_as_inviter
  acts_as_invitee

  has_many :user_parties
  has_many :parties, through: :user_parties

  private

  class << self
    def user_invited_user_to_party(invitation)
      :send_invitation_created_alert_to_invitee
    end

    def user_accepted_invite_from_user_to_party(invitation)
      invitation.invited_to.users << invitation.invitee
      :send_invitation_accepted_alert_to_inviter
    end

    def user_declined_invite_from_user_to_party(invitation)
      :send_invitation_declined_alert_to_inviter
    end

    def user_reset_invite_from_user_to_party(invitation)
      :send_invitation_reset_alert_to_invitee
    end
  end
end
