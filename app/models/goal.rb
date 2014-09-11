class Goal < ActiveRecord::Base

	belongs_to :user
	belongs_to :category

	before_save :default_state_value	

	
	def default_state_value
		if self.fim >= Date.today
			self.estado = 0
		#else self.estado = 1
		end
	end

	def contaDias
		@dias = self.fim - Date.current
		@dias.to_i
	end

	
end
