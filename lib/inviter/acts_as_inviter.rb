module Inviter
  module ActsAsInviter
    extend ActiveSupport::Concern
    class << self
      attr_reader :inviters
    end

    included do
      has_many :sent_invitations, as: :inviter, class_name: "Invitation"
    end

    def send_invitation(invitee, invited_to)
      Invitation.create(inviter: self, invitee: invitee, invited_to: invited_to)
    end

    private

    def self.included(base)
      @inviters ||= []
      @inviters << base
    end
  end
end
