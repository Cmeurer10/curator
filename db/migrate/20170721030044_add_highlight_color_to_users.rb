class AddHighlightColorToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :highlight_color, :string, null: false, default: '#F9FF3E'
  end
end
