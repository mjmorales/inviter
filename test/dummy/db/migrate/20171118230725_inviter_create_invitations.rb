class InviterCreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.references :inviter, polymorphic: true, index: true, null: false
      t.references :invitee, polymorphic: true, index: true, null: false
      t.references :invited_to, polymorphic: true, index: true, null: false
      t.timestamps
    end
  end
end
