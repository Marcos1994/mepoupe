class Entry < ActiveRecord::Base
	has_many :parts, dependent: :destroy, autosave: true
	belongs_to :category
	
	
	#validadores
	validates :titulo, :tipo, :periodicidade, :category_id, presence: true
	
	
	#tipo da entrada:	Date
	#tipo da saida:		Part[]
	#saida: colecao de parcelas deste lancamento na data "data"
	def parcelas_mes(data)
		@parts = []
		self.parts.each do |p|
			if((p.data.month == data.month) && (p.data.year == data.year))
				@parts << p
			end
		end
		@parts
	end
	
	
	
	#tipo da entrada:	Date
	#tipo da saida:		Part[]
	#saida: colecao de parcelas deste lancamento ate a data "data"
	def parcelas_ate_mes(data)
		@parts = []
		self.parts.each do |p|
			if((p.data.month <= data.month) && (p.data.year <= data.year))
				@parts << p
			end
		end
		@parts
	end
	
	
	
	#tipo da entrada:	Date
	#tipo da saida:		boolean
	#saida: true se este lancamento tiver alguma parcela no mes de "data"
	def mes_nao_efetivado(data)
		self.parts.each do |p|
			if((p.data.month <= data.month) && (p.data.year <= data.year) && (p.confirmacao == 0))
				return true
			end
		end
		return false
	end
	
	
	
	#tipo da saida:		double
	#saida: o valor total deste lancamento
	def valor
		@valor = 0
		self.parts.each do |p|
			@valor += p.valor
		end
		@valor
	end
	
	
	
	#tipo da saida:		double
	#saida: valor da soma das parcelas efetivadas deste lancamento
	def valor_efetivado
		self.valor_total(1)
	end
	
	
	
	#tipo da saida:		double
	#saida: valor da soma das parcelas nao efetivadas deste lancamento
	def valor_pendente
		self.valor_total(0)
	end
	
	
	
	#tipo da saida:		int
	#saida: porcentagem em inteiro o valor ja efetivado do lancamento
	def valor_razao_efetivado
		((self.valor_efetivado * 100) / self.valor).to_i
	end
	
	
	
	#tipo da entrada:	int (0 para naoEfetivado e 1 para efetivado)
	#tipo da saida:		double
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
