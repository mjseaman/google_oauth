class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :photo_url
      t.string :access_token
      t.timestamps
    end
  end
end
