class CreateSemicontributions < ActiveRecord::Migration
  def change
    create_table :semicontributions do |t|
			t.decimal :max_lat, :precision => 9, :scale => 6, :null => false
			t.decimal :max_lon, :precision => 9, :scale => 6, :null => false
			t.decimal :min_lat, :precision => 9, :scale => 6, :null => false
			t.decimal :min_lon, :precision => 9, :scale => 6, :null => false
      t.timestamps null: false
    end
  end
end
