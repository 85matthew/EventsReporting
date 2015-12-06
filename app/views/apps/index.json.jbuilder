json.array!(@app_names) do |app_name|
  json.extract! app_name, :id, :app_name, :business_relevant
  json.url app_name_url(app_name, format: :json)
end
