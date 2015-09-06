json.array!(@disasters) do |disaster|
  json.extract! disaster, :id, :name, :description
  json.url disaster_url(disaster, format: :json)
end
