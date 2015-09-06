class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
			t.string :name, :null => false
			t.text :description, :null => false, :limit => 20
      t.timestamps null: false
    end
  end
end
