json.extract! chatinfo, :id, :activity_id, :user_id, :content, :created_at, :updated_at
json.url chatinfo_url(chatinfo, format: :json)