class AddTypeToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :is_deposit, :boolean, :default => true
  end
end
