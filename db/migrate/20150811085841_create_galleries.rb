class CreateGalleries < ActiveRecord::Migration
  def up
    create_table :galleries do |t|
      t.belongs_to :service, index: true, foreign_key: true, null: false, required: true

      t.timestamps null: false
    end
  end

  def down
  	drop_table :galleries
  end
end
