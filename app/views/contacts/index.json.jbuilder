json.array!(@contacts) do |contact|
  json.extract! contact, :id, :first_name, :last_name, :email, :title, :office_phone, :mobile_phone, :contact_method, :customer_id
  json.url contact_url(contact, format: :json)
end
