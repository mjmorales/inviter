module Inviter
  require 'inviter/invitation_callbacks'
  require 'inviter/acts_as_invited_to'
  require 'inviter/acts_as_invitee'
  require 'inviter/acts_as_inviter'
  require 'app/models/concerns/inviterable'
  require 'app/models/invitation'
end
