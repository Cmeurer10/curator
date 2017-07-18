class AddAvatarsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatars, :json
  end
end
