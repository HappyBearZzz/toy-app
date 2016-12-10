json.extract! activity, :id, :title, :content, :category, :start_at, :end_at, :location, :user_id, :created_at, :updated_at
json.url activity_url(activity, format: :json)