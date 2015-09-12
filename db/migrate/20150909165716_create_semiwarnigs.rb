class CreateSemiwarnigs < ActiveRecord::Migration
  def change
    create_table :semiwarnigs do |t|
			t.decimal :max_lat, :precision => 9, :scale => 6
			t.decimal :max_lon, :precision => 9, :scale => 6
			t.decimal :min_lat, :precision => 9, :scale => 6
			t.decimal :min_lon, :precision => 9, :scale => 6
      t.timestamps null: false
    end
  end
end
