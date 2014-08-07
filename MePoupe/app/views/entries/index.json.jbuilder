json.array!(@entries) do |entry|
  json.extract! entry, :id, :titulo, :descricao, :tipo, :periodicidade
  json.url entry_url(entry, format: :json)
end
