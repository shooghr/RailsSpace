json.array!(@posts) do |post|
  json.extract! post, :id, :blog_id, :title, :body
  json.url post_url(post, format: :json)
end
