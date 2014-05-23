json.array!(@customers) do |customer|
  json.extract! customer, :id, :business_name, :billing_address, :street_address, :suit_unit, :city, :zip_code, :country_id, :state_id, :phone, :website, :contact_id
  json.url customer_url(customer, format: :json)
end
