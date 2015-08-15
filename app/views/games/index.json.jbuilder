json.array!(@games) do |game|
  json.extract! game, :id, :name, :endpoint, :description
  json.url game_url(game, format: :json)
end
