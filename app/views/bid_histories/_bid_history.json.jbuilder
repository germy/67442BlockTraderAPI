json.extract! bid_history, :id, :user_id, :order_id, :price, :created_at, :updated_at
json.url bid_history_url(bid_history, format: :json)