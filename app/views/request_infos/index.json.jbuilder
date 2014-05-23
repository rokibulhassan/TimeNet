json.array!(@request_infos) do |request_info|
  json.extract! request_info, :id, :first_name, :last_name, :email, :comments, :query
  json.url request_info_url(request_info, format: :json)
end
