class AddCoverToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :cover, :string
  end
end
