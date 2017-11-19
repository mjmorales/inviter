module Inviter
  module ActsAsInvitation
    extend ActiveSupport::Concern
    class << self
      attr_reader :invitations
    end

    included do
      has_many :invitations, as: :invited_to
    end

    private

    def self.included(base)
      @invitations ||= []
      @invitations << base
    end
  end
end
