class ReportController < ApplicationController
	def index
		@categories = current_user.categories
	end
	
	def receita
		@categories = current_user.categories
	end
	
	def despesa
		@categories = current_user.categories
	end
end
