class Party < ApplicationRecord
  acts_as_invitation

  has_many :user_parties
  has_many :users, through: :user_parties
end
