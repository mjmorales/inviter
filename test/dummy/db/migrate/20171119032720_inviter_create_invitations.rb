class InviterCreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.references :inviter, polymorphic: true, index: true, null: false
      t.references :invitee, polymorphic: true, index: true, null: false
      t.references :invited_to, polymorphic: true, index: true, null: false
      t.timestamp :accepted_at
      t.timestamp :declined_at
      t.timestamps
    end

    add_index(:invitations, :accepted_at)
    add_index(:invitations, :declined_at)
    add_index(:invitations, [:accepted_at, :declined_at])
    add_index(:invitations, [:inviter_id, :inviter_type, :invitee_type, :invitee_id, :invited_to_id,
                             :invited_to_type], unique: true, name: :unique_invitation_index)
  end
end
