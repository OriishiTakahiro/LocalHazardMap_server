class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
			t.string :name, :null => false
			t.string :pw, :null => false, :limit => 20
			# 0:その他, 1:user, 2:自治体, 3:市町村, 4:県, 5:気象庁
			t.integer :rank, :null => false
			t.text :description, :null => false, :limit => 20
      t.timestamps null: false
    end
  end
end
