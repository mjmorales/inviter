module Inviter
  module InvitationCallbacks
    def self.invitation_created_callback(inviter, invitee, invited_to)
      "#{inviter.class.name}_invited_#{invitee.class.name}_to_#{invited_to.class.name}".downcase.to_sym
    end
  end
end
