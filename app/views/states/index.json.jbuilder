json.array!(@states) do |state|
  json.extract! state, :id, :state_abbr
  json.url state_url(state, format: :json)
end
