class HomeController < ApplicationController
	def index
		if (current_user.categories.length < 1)	#O usuário deve ter pelo menos 1 categoria
			category_params = { "titulo" => "Geral", "cor" => "#cccccc", "descricao" => "Essa e a categoria geral do sistema." }
			@category = Category.new(category_params)
			@category.user = current_user
			@category.save

		end
		
		@goals = current_user.goals
		
		@goals.each do |g|
			if g.estado == 1 && g.fim > Date.today
				g.estado = 0
			end
		end
		
	end
	
	def resetar
		current_user.categories.destroy_all
		#@categorias = current_user.categories
		#@categorias.each do |cat|
		#	@lancamentos = Entry.find(:all, :conditions => 'category_id = ' + cat.id.to_s)
		#	@lancamentos.each do |lanc|
		#		lanc.destroy
		#	end
		#	cat.destroy
		#end
		respond_to do |format|
			  format.html { redirect_to home_index_url }
			  format.json { head :no_content }
		end
	end
end
