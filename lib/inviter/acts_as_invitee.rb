module Inviter
  module ActsAsInvitee
    extend ActiveSupport::Concern
    class << self
      attr_reader :invitees
    end

    included do
      has_many :invitations, as: :invitee
    end

    private

    def self.included(base)
      @invitees ||= []
      @invitees << base
    end
  end
end
