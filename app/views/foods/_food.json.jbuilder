json.extract! food, :id, :name, :original_price, :resturant_id, :created_at, :updated_at
json.url food_url(food, format: :json)