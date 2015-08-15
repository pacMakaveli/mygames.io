json.array!(@wishlists) do |wishlist|
  json.extract! wishlist, :id, :name, :description, :user_id
  json.url wishlist_url(wishlist, format: :json)
end
