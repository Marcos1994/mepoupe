class Category < ActiveRecord::Base
	has_many :entries, dependent: :destroy
	belongs_to :user
	has_many :goals
	
	def valor_receita
		@valor = 0
		self.entries.each do |e|
			if(e.tipo == 1)
				@valor += e.valor
			end
		end
		@valor
	end
	
	def valor_receita_efetivado
		@valor = 0
		self.entries.each do |e|
			if(e.tipo == 1)
				@valor += e.valor_efetivado
			end
		end
		@valor
	end
	
	def valor_despesa
		@valor = 0
		self.entries.each do |e|
			if(e.tipo == 0)
				@valor += e.valor
			end
		end
		@valor
	end
	
	def valor_despesa_efetivado
		@valor = 0
		self.entries.each do |e|
			if(e.tipo == 0)
				@valor += e.valor_efetivado
			end
		end
		@valor
	end
	
	def valor_razao_receita
		val = 0
		self.user.categories.each do |c|
			val += c.valor_receita
		end
		if(val != 0)
			@valor = (self.valor_receita * 100)/val
		else
			@valor = 0
		end
	end
	
	def valor_razao_despesa
		val = 0
		self.user.categories.each do |c|
			val += c.valor_despesa
		end
		if(val != 0)
			@valor = (self.valor_despesa * 100)/val
		else
			@valor = 0
		end
	end
	
end
