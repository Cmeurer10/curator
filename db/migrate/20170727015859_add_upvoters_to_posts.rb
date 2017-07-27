class AddUpvotersToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :upvoters, :string, array: true, default: []
  end
end
