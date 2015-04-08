class ChangeShows < ActiveRecord::Migration
  def change
    add_column :shows, :db_id, :string
  end
end
