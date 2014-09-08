class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable
	has_many :categories
	has_many :goals
	
	
	
	#tipo da saida:		Entry[]
	#saida: mostra os lancamentos nao efetivados ate a data atual
	def lancamentos_para_efetivar
		@entries = []
		self.categories.each do |c|
			c.lancamentos_ate_mes(Date.today).each do |e|
				if(e.mes_nao_efetivado(Date.today))
					@entries << e
				end
			end
		end
		@entries
	end
	
	
	
	#tipo da saida:		float
	#saida: mostra o saldo do usuario (receitasEfetivadas - despesasEfetivadas)
	def saldo
		@saldo = 0
		self.categories.each do |cat|
			@saldo += cat.valor_receita_efetivado
			@saldo -= cat.valor_despesa_efetivado
		end
		@saldo
	end
	
	
	
	#tipo da entrada:	Date
	#tipo da saida:		double
	#saida: retorna a receita total do mes de 'data'
	def receita_mes(data)
		@valor = 0
		self.categories.each do |c|
			@valor += c.valor_receita_mes(data)
		end
		@valor
	end
	
	
	
	#tipo da entrada:	Date
	#tipo da saida:		double
	#saida: retorna a despesa total do mes de 'data'
	def despesa_mes(data)
		@valor = 0
		self.categories.each do |c|
			@valor += c.valor_despesa_mes(data)
		end
		@valor
	end
end
