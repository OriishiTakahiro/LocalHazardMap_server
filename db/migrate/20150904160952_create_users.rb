class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
			t.string :name, :null => false, :limit => 20
			t.string :pw, :null => false, :limit => 20
      t.timestamps null: false
    end
  end
end
