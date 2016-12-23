json.extract! message, :id, :from_userid, :to_userid, :content, :created_at, :updated_at
json.url message_url(message, format: :json)