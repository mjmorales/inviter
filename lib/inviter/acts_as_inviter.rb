module Inviter
  module ActsAsInviter
    extend ActiveSupport::Concern
    class << self
      attr_reader :inviters
    end

    private

    def self.included(base)
      @inviters ||= []
      @inviters << base
    end
  end
end
