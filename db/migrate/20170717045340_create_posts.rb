class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :votes, default: 0
      t.integer :flag, default: 0
      t.references :conversation, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
