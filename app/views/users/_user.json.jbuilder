json.extract! user, :id, :name, :hashed_password, :no, :age, :sex, :college, :major, :school_year, :description, :salt, :created_at, :updated_at
json.url user_url(user, format: :json)