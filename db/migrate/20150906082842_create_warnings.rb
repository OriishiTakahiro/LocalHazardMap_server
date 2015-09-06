class CreateWarnings < ActiveRecord::Migration
  def change
    create_table :warnings do |t|
			t.integer :layer_id, :null => false
			t.integer :disaster_id, :null => false
			t.string :apexes, :null => false
      t.timestamps null: false
    end
  end
end
