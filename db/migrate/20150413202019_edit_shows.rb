class EditShows < ActiveRecord::Migration
  def change
    add_column :shows, :actors, :json
  end
end
