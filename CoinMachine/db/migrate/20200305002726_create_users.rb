class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.boolean :is_admin, :default => false
      t.string :api_key
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
