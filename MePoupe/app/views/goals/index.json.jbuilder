json.array!(@goals) do |goal|
  json.extract! goal, :id, :titulo, :descricao, :inicio, :fim, :estado
  json.url goal_url(goal, format: :json)
end
