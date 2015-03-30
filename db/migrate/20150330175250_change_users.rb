class ChangeUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :fb_id, :integer
    add_column :users, :fb_token, :string
    add_column :users, :zipcode, :string
    add_column :users, :provider, :string
    add_column :users, :avatar, :string
    add_column :users, :fb_data, :text
  end
end
