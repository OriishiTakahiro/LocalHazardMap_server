class CreateLayers < ActiveRecord::Migration
  def change
    create_table :layers do |t|
			t.integer :org_id, :null => false
			t.decimal :center_lat, :precision => 9, :scale => 6, :default => 35.685075
			t.decimal :center_lon, :precision => 9, :scale => 6, :default => 139.752762
      t.timestamps null: false
    end
  end
end
