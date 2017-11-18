class CreateUserParties < ActiveRecord::Migration[5.1]
  def change
    create_table :user_parties do |t|
      t.references :user, foreign_key: true
      t.references :party, foreign_key: true

      t.timestamps
    end
  end
end
