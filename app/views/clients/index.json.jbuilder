json.array!(@clients) do |client|
  json.extract! client, :id, :business_name, :billing_address, :street_address, :suit_unit, :city, :zip_code, :country_id, :state_id, :phone, :website, :user_id
  json.url client_url(client, format: :json)
end
