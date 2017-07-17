class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.string :topic
      t.integer :start_index
      t.integer :end_index
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
