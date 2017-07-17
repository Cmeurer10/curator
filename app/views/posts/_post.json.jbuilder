json.extract! post, :id, :votes, :flag, :conversation_id, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
