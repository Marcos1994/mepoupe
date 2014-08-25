json.array!(@parts) do |part|
  json.extract! part, :id, :valor, :data, :confirmacao
  json.url part_url(part, format: :json)
end
