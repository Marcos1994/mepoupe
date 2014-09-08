class HomeController < ApplicationController
	def index
		if (current_user.categories.length < 1)	#O usuário deve ter pelo menos 1 categoria
			category_params = { "titulo" => "Geral", "cor" => "#cccccc", "descricao" => "Essa e a categoria geral do sistema." }
			@category = Category.new(category_params)
			@category.user = current_user
			@category.save

		end
		
		@goals = current_user.goals
		
	end
	
	def resetar
		current_user.categories.destroy_all
		current_user.goals.destroy_all
		respond_to do |format|
			  format.html { redirect_to home_index_url }
			  format.json { head :no_content }
		end
	end
end
