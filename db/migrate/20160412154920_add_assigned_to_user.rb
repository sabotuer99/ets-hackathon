class AddAssignedToUser < ActiveRecord::Migration
  def change
    add_column :items, :assigned_to, :string
  end
end
