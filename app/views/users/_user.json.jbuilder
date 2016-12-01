json.extract! user, :id, :first_name, :last_name, :email, :fb_id, :api_authtoken, :authtoken_expiry, :phone, :custID, :created_at, :updated_at
json.url user_url(user, format: :json)