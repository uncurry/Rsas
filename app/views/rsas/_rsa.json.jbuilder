json.extract! rsa, :id, :n, :e, :d, :messages, :encrypt_messages, :decrypt_messages, :created_at, :updated_at
json.url rsa_url(rsa, format: :json)
