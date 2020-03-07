class AddReferenceToCoins < ActiveRecord::Migration[5.2]
  def change
    add_reference :coins, :user, foreign_key: true
  end
end
