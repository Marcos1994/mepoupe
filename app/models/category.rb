class Category < ActiveRecord::Base
	has_many :entries, dependent: :destroy
	belongs_to :user
	has_many :goals
	
	
	
	#---Lançamentos---#
	
	def lancamentos_mes(data)
		@entries = []
		self.entries.each do |e|
			e.parts.each do |p|
				if((p.data.month == data.month) && (p.data.year == data.year))
					@entries << e
					break
				end
			end
		end
		@entries
	end
	
	def lancamentos_ate_mes(data)
		@entries = []
		self.entries.each do |e|
			e.parts.each do |p|
				if((p.data.month <= data.month) && (p.data.year <= data.year))
					@entries << e
					break
				end
			end
		end
		@entries
	end
	
	
	
	#---Receita---#
	
	def valor_receita
		@valor = 0
		self.entries.each do |e|
			if(e.tipo == 1)
				@valor += e.valor
			end
		end
		@valor
	end
	
	def valor_receita_mes(data)
		@valor = 0
		self.entries.each do |e|
			if(e.tipo == 1)
				e.parcelas_mes(data).each do |p|
					@valor += p.valor
				end
			end
		end
		@valor
	end
	
	def valor_razao_receita_mes(data)
		val = 0
		self.user.categories.each do |c|
			val += c.valor_receita_mes(data)
		end
		if(val != 0)
			@valor = (self.valor_receita_mes(data) * 100)/val
		else
			@valor = 0
		end
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
	
	
	
	#---Despesa---#
	
	def valor_despesa
		@valor = 0
		self.entries.each do |e|
			if(e.tipo == 0)
				@valor += e.valor
			end
		end
		@valor
	end
	
	def valor_despesa_mes(data)
		@valor = 0
		self.entries.each do |e|
			if(e.tipo == 0)
				e.parcelas_mes(data).each do |p|
					@valor += p.valor
				end
			end
		end
		@valor
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
	
	def valor_razao_despesa_mes(data)
		val = 0
		self.user.categories.each do |c|
			val += c.valor_despesa_mes(data)
		end
		if(val != 0)
			@valor = (self.valor_despesa_mes(data) * 100)/val
		else
			@valor = 0
		end
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
	
end
