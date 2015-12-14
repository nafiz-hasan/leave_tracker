json.array!(@holidays) do |holiday|
  json.extract! holiday, :id, :user_id, :reason, :description, :holiday_type, :status
  json.url holiday_url(holiday, format: :json)
end
