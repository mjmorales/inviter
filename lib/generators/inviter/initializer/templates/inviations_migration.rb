class InviterCreateInvitations < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :user_parties do |t|
      t.references :inviter, polymorphic: true, index: true, null: false
      t.references :invitee, polymorphic: true, index: true, null: false
      t.references :invited_to, polymorphic: true, index: true, null: false
      t.timestamps
    end
  end
end
