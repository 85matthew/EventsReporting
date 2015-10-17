json.array!(@urls) do |url|
  json.extract! url, :id, :domain, :keyword, :business_relevant
  json.url url_url(url, format: :json)
end
