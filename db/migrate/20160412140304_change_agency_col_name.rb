class ChangeAgencyColName < ActiveRecord::Migration
  def change
    rename_column :agencies, :name, :agency_name
  end
end
