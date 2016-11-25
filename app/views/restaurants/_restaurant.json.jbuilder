json.extract! resturant, :id, :name, :latitude, :longitude, :address, :hours, :created_at, :updated_at
json.url resturant_url(resturant, format: :json)