class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false
      t.integer :value, null: false
      t.integer :voteable_id, null: false
      t.string :voteable_type, null: false

      t.timestamps null: false
    end

    add_index :votes, :voteable_id
  end
end
