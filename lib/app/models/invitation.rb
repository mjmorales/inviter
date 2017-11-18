class Invitation < ActiveRecord::Base
  belongs_to :inviter, polymorphic: true
  belongs_to :invitee, polymorphic: true
  belongs_to :invited_to, polymorphic: true

  after_create :trigger_callbacks

  private

  def trigger_callbacks
    puts 'CALL BACKS WILL BE TRIGGERED'
  end
end
