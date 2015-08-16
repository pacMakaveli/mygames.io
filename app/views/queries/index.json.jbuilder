json.array!(@queries) do |query|
  json.extract! query, :id, :query, :count
  json.url query_url(query, format: :json)
end
