class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable
	has_many :categories
	has_many :goals
	
	def lancamentos_para_efetivar
		@entries = []
		self.categories.each do |c|
			c.lancamentos_mes(Date.today).each do |e|
				if(e.mes_nao_efetivado(Date.today))
					@entries << e
				end
			end
		end
		@entries
	end
	
	def saldo
		@saldo = 0
		self.categories.each do |cat|
			@saldo += cat.valor_receita_efetivado
			@saldo -= cat.valor_despesa_efetivado
		end
		@saldo
	end
	
	def receita_mes(data)
		@valor = 0
		self.categories.each do |c|
			@valor += c.valor_receita_mes(data)
		end
		@valor
	end
	
	def despesa_mes(data)
		@valor = 0
		self.categories.each do |c|
			@valor += c.valor_despesa_mes(data)
		end
		@valor
	end
end
