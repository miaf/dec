class CreateServices < ActiveRecord::Migration
  def up
    create_table :services do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: false, required: true

      t.timestamps null: false
    end
  end

  def down
  	drop_table :services
  end
end
