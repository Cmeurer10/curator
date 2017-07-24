class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.string :topic
      t.integer :start_index
      t.integer :end_index
      t.integer :parent_id, null: true, default: nil
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
