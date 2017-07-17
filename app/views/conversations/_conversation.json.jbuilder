json.extract! conversation, :id, :book_id, :created_at, :updated_at
json.url conversation_url(conversation, format: :json)
