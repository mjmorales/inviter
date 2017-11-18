class Party < ApplicationRecord
  include Inviter::ActsAsInvitation
end
