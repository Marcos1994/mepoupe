class Category < ActiveRecord::Base
	has_many :entries, dependent: :destroy
	belongs_to :user
	has_many :goals
	
	
	
	#tipo da saida:		string
	#saida: sequencia de 10 pares cartesianos separados por virgulas entre si e espacos entre os outros
	#		os pontos sao referentes aa variacao no valor das receitas durante os 10 ultimos meses
	#		os pontos vao de 0,200 a 540,0 onde 200 eh o Y minimo e 540 eh o X mais antigo
	def gerar_pontos_receita
		@pontos = ''
		data = Date.today
		for i in 0..9 do
			@pontos += (60 * i).to_s + ',' + (200 - (self.valor_razao_receita_mes(data)*2)).to_s + ' '
			data = data - 1.months
		end
		@pontos
	end
	
	
	
	#tipo da saida:		string
	#saida: sequencia de 10 pares cartesianos separados por virgulas entre si e espacos entre os outros
	#		os pontos sao referentes aa variacao no valor das despesas durante os 10 ultimos meses
	#		os pontos vao de 0,200 a 540,0 onde 200 eh o Y minimo e 540 eh o X mais antigo
	def gerar_pontos_despesa
		@pontos = ''
		data = Date.today
		for i in 0..9 do
			@pontos += (60 * i).to_s + ',' + (200 - (self.valor_razao_despesa_mes(data)*2)).to_s + ' '
			data = data - 1.months
		end
		@pontos
	end
	
	
	
	#---Lançamentos---#
	
	#tipo da entrada:	Date
	#tipo da saida:		Entry[]
	#saida: retorna uma colecao contendo os lancamentos desta categodia no mes de 'data'
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
	
	
	
	#tipo da entrada:	Date
	#tipo da saida:		Entry[]
	#saida: retorna uma colecao contendo os lancamentos desta categodia ate o mes de 'data'
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
	
	#tipo da saida:		double
	#saida: retorna a soma de todas as receitas desta categoria
	def valor_receita
		@valor = 0
		self.entries.each do |e|
			if(e.tipo == 1)
				@valor += e.valor
			end
		end
		@valor
	end
	
	
	
	#tipo da entrada:	Date
	#tipo da saida:		double
	#saida: retorna a soma da receita total desta categoria no mes de 'data'
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
	
	
	
	#tipo da entrada:	Date
	#tipo da saida:		double
	#saida: retorna a porcentagem do valor da receita total desta categoria em relacao aas outras no mes de 'data'
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
	
	
	
	#tipo da saida:		double
	#saida: retorna a soma de todas as receitas efetivadas desta categoria
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
	
	#tipo da saida:		double
	#saida: retorna a soma de todas as despesas desta categoria
	def valor_despesa
		@valor = 0
		self.entries.each do |e|
			if(e.tipo == 0)
				@valor += e.valor
			end
		end
		@valor
	end
	
	
	
	#tipo da entrada:	Date
	#tipo da saida:		double
	#saida: retorna a soma da despesa total desta categoria no mes de 'data'
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
	
	
	
	#tipo da entrada:	a
	#tipo da saida:		a
	#saida: a
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
	
	
	
	#tipo da entrada:	Date
	#tipo da saida:		double
	#saida: retorna a porcentagem do valor da despesa total desta categoria em relacao aas outras no mes de 'data'
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
	
	
	
	#tipo da saida:		double
	#saida: retorna a soma de todas as despesas efetivadas desta categoria
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
