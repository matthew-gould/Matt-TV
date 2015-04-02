class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :name
      t.string :premiere
      t.string :day
      t.string :time
      t.string :station
      t.datetime :reminder
      t.text :summary
      t.string :pic_url

      t.timestamps null: false
    end
  end
end
