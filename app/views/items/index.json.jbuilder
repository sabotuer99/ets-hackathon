json.array!(@items) do |item|
  json.extract! item, :id, :description, :agency_id, :street, :city, :state_id, :zip, :loc_lat, :loc_long
  json.url item_url(item, format: :json)
end
