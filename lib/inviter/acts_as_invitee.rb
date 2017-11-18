module Inviter
  module ActsAsInvitee
    extend ActiveSupport::Concern
    class << self
      attr_reader :invitees
    end

    private

    def self.included(base)
      @invitees ||= []
      @invitees << base
    end
  end
end
