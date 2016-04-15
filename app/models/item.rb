class Item < ActiveRecord::Base
      attr_accessible :description,:agency_id,:street,:city,:state_id,:zip,:loc_lat,:loc_long,:assigned_to, :state_asset_tag, :date_acquired, :orig_cost
end
