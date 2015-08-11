class CreateServiceLanguages < ActiveRecord::Migration
  def change
    create_table :service_languages do |t|
    	t.belongs_to :service, index: true, foreign_key: true, null: false, required: true
    	# t.belongs_to :language, index: true, foreign_key: true, null: false, required: true
      t.string :language, null: false, limit: 2
    	t.string :slug, null: false, limit: 30, unique: true, index: true
    	t.string :description, null: false
    	t.text :content, null: false

      t.timestamps null: false
    end
  end
end
