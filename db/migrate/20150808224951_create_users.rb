class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      # t.string :id, null: false, primary_key: true
      t.string :first_name, null: false, limit: 50
      t.string :last_name, null: false, limit: 50
      t.date :date_of_birth, null: false
      t.string :gender, null: false, limit: 1
      t.string :nationality, null: false, limit: 20
      t.string :country, null: false, limit: 30
      t.string :email, null: false, limit: 100, unique: true, index: true
      t.string :phone, null:false, limit: 15
      t.string :address, null: false
      t.string :login_name, null: false, limit: 20, unique: true, index: true
      t.string :password_salt, null: false
      t.string :password_hash, null: false
      t.boolean :email_confirmed, default: false
      t.string :confirm_token
      t.datetime :confirmation_expires_after
      t.string :password_reset_token
      t.datetime :password_expires_after
      t.text :description
      t.boolean :activated, default: false
      t.string :image_profile

      t.timestamps null: false
    end

    # # add a CHECK constraint
    # execute <<-SQL
    #   ALTER TABLE user
    #     ADD CONSTRAINT date_ck
    #     CHECK (date_of_birth < Date.now);
    # SQL
  end

  def down

    # execute <<-SQL
    #   ALTER TABLE users
    #     DROP CONSTRAINT date_ck
    # SQL

    drop_table :users
  end
end
