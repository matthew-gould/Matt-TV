class ChangeUser < ActiveRecord::Migration
  def change
    remove_column :users, :zipcode
    remove_column :users, :provider
  end
end
