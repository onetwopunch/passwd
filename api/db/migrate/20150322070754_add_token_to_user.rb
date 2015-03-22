class AddTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    add_index :users, ["token"], :name => "index_users_on_token"
  end
end
