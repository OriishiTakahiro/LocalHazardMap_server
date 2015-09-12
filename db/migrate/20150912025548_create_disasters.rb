class CreateDisasters < ActiveRecord::Migration
  def change
    create_table :disasters do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
