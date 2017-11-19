class Party < ApplicationRecord
  acts_as_invited_to

  has_many :user_parties
  has_many :users, through: :user_parties
end
