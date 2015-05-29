json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :name, :url, :user_id, :path_id
  json.url lesson_url(lesson, format: :json)
end
