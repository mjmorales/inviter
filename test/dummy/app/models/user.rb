class User < ApplicationRecord
  include Inviter::ActsAsInviter
  include Inviter::ActsAsInvitee

  has_many :user_parties
  has_many :parties, through: :user_parties
end
