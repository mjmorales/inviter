class Party < ApplicationRecord
  include Inviter::ActsAsInvitation
  has_many :user_parties
  has_many :users, through: :user_parties
end
