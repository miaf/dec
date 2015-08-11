class CreateLanguages < ActiveRecord::Migration
  def up
    create_table :languages do |t|
    	t.string :code, null: false, limit: 2, unique: true
    	t.string :name, null: false, limit: 30, unique: true

      t.timestamps null: false
    end
  end

  def down
  	drop_table :languages
  end
end
