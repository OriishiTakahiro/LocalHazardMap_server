class CreateLayers < ActiveRecord::Migration
  def change
    create_table :layers do |t|
			t.integer :org_id, :null => false
			t.decimal :max_lat, :precision => 9, :scale => 6, :nul => false
			t.decimal :max_lon, :precision => 9, :scale => 6, :nul => false
			t.decimal :min_lat, :precision => 9, :scale => 6, :nul => false
			t.decimal :min_lon, :precision => 9, :scale => 6, :nul => false
			t.integer :num_of_vertical_div, :null => false
			t.integer :num_of_horizontal_div, :null => false
      t.timestamps null: false
    end
  end
end