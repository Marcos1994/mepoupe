class Entry < ActiveRecord::Base
	has_many :parts, dependent: :destroy, autosave: true
	belongs_to :category
	
	def parcelas_mes(data)
		@parts = []
		self.parts.each do |p|
			if((p.data.month == data.month) && (p.data.year == data.year))
				@parts << p
			end
		end
		@parts
	end
	
	def parcelas_ate_mes(data)
		@parts = []
		self.parts.each do |p|
			if((p.data.month <= data.month) && (p.data.year <= data.year))
				@parts << p
			end
		end
		@parts
	end
	
	def mes_nao_efetivado(data)
		self.parts.each do |p|
			if((p.data.month <= data.month) && (p.data.year <= data.year) && (p.confirmacao == 0))
				return true
			end
		end
		return false
	end
	
	def valor
		@valor = 0
		self.parts.each do |p|
			@valor += p.valor
		end
		@valor
	end
	
	def valor_efetivado
		self.valor_total(1)
	end
	
	def valor_pendente
		self.valor_total(0)
	end
	
	def valor_razao_efetivado
		((self.valor_efetivado * 100) / self.valor).to_i
	end
	
	#Auxiliar de valor_efetivado e valor_pendente
	def valor_total(estado)
		@valor = 0
		self.parts.each do |p|
			if(p.confirmacao == estado)
				@valor += p.valor
			end
		end
		@valor
	end
end
