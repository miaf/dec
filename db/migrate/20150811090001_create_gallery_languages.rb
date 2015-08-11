class CreateGalleryLanguages < ActiveRecord::Migration
  def up
    create_table :gallery_languages do |t|
      t.belongs_to :gallery, index: true, foreign_key: true, null: false, required: true
      t.string :language, null: false, limit: 2
      t.string :slug, null: false, limit: 30, unique: true
      t.string :description, null: false

      t.timestamps null: false
    end
  end

  def down
  	drop_table :gallery_languages
  end
end
