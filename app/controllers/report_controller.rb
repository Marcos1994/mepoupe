class ReportController < ApplicationController
	def index
		@categories = current_user.categories
	end
end
