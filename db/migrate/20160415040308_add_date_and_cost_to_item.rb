class AddDateAndCostToItem < ActiveRecord::Migration
  def change
    add_column :items, :date_acquired, :date
    add_column :items, :orig_cost, :float
  end
end
