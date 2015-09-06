class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
			t.integer :user_id, :null => false, :original => true
			t.decimal :latitude, :precision => 9, :scale => 6
			t.decimal :longitude, :precision => 9, :scale => 6
      t.timestamps null: false
    end
  end
end
