class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
			t.integer :user_id, :null => false
			t.integer :risk_level, :null => false, :default => 0
			t.decimal :latitude, :precision => 9, :scale => 6, :nul => false
			t.decimal :longitude, :precision => 9, :scale => 6, :nul => false
			t.string :title, :null => false
			t.text :description
			t.binary :img, :limit =>  5.megabyte
      t.timestamps null: false
    end
  end
end
