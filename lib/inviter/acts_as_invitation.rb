module Inviter
  module ActsAsInvitation
    extend ActiveSupport::Concern
    class << self
      attr_reader :invitations
    end

    private

    def self.included(base)
      @invitations ||= []
      @invitations << base
    end
  end
end
