class CreateWarnings < ActiveRecord::Migration
  def change
    create_table :warnings do |t|
			t.integer :layer_id, :null => false
			t.integer :disaster_id, :null => false
			# 1..6
			t.integer :risk_level, :null => false, :default => 1
			t.string :apexes, :null => false
      t.timestamps null: false
    end
  end
end
