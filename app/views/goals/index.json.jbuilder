json.array!(@goals) do |goal|
  json.extract! goal, :id, :titulo, :descricao, :inicio, :fim, :estado, :valor, :category_id, :user_id 
  json.url goal_url(goal, format: :json)
end
