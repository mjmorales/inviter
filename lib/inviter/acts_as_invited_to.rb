module Inviter
  module ActsAsInvitedTo
    extend ActiveSupport::Concern
    class << self
      attr_reader :invited_tos
    end

    included do
      has_many :invitations, as: :invited_to
    end

    private

    def self.included(base)
      @invited_tos ||= []
      @invited_tos << base
    end
  end
end
