module Inviter
  module InvitationCallbacks
    class << self
      def invitation_created_callback(inviter, invitee, invited_to)
        "#{inviter.class.name}_invited_#{invitee.class.name}_to_#{invited_to.class.name}".downcase
      end

      ['accepted', 'declined', 'reset'].each do |action|
        define_method("invitation_#{action}_callback") do |inviter, invitee, invited_to|
          "#{invitee.class.name}_#{action}_invite_from_#{inviter.class.name}_to_#{invited_to.class.name}".downcase
        end
      end
    end
  end
end
