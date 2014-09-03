class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable
	has_many :categories
	has_many :goals
	
	def saldo
		@saldo = 0
		categories.each do |cat|
			@saldo += cat.valor_receita_efetivado
			@saldo -= cat.valor_despesa_efetivado
		end
		@saldo
	end
end
