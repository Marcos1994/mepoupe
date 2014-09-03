class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable
	has_many :categories
	has_many :goals
	
	def saldo
		@saldo = 0
		current_user.categories.each do |cat|
			@saldo += valor_receita_efetivado
			@saldo -= valor_despesa_efetivado
		end
	end
end
