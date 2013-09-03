json.array!(@repositories) do |repository|
  json.extract! repository, :name
  json.url repository_url(repository, format: :json)
end
