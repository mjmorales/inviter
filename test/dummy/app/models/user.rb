class User < ApplicationRecord
  include Inviter::ActsAsInviter
  include Inviter::ActsAsInvitee
end
