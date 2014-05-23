json.array!(@projects) do |project|
  json.extract! project, :id, :name, :number, :customer_id, :contact_id, :start_date, :end_date, :notes
  json.url project_url(project, format: :json)
end
