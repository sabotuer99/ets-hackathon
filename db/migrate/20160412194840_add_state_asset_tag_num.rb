class AddStateAssetTagNum < ActiveRecord::Migration
  def change
    add_column :items, :state_asset_tag, :string
  end
end
