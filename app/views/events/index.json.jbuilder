json.array!(@events) do |event|
  json.extract! event, :id, :app_name, :user_id, :user_type, :tenant, :url, :domain, :duration, :search_words, :start_time_stamp, :end_time_stamp
  json.url event_url(event, format: :json)
end
