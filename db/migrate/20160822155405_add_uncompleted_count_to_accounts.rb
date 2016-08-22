class AddUncompletedCountToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :uncompleted_count, :integer, default: 0
  end
end
