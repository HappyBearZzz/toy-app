json.extract! admin, :id, :name, :hashed_password, :salt, :created_at, :updated_at
json.url admin_url(admin, format: :json)