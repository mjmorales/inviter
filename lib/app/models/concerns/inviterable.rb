module Inviterable
  extend ActiveSupport::Concern

  private

  module ClassMethods
    def acts_as_inviter
      self.include(Inviter::ActsAsInviter)
    end

    def acts_as_invitee
      self.include(Inviter::ActsAsInvitee)
    end

    def acts_as_invited_to
      self.include(Inviter::ActsAsInvitedTo)
    end
  end
end
