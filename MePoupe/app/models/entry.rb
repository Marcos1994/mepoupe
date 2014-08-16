class Entry < ActiveRecord::Base
	has_many :parts, dependent: :destroy
	belongs_to :ctegory
	#after_create :criar_parcelas
	
	#def initialize(dados)
	#	super(dados)
		
	#end
	
	def criar_parcelas(dados)
		if(periodicidade != 1)
			dados.parcelas = 1
		end
		
		for i in (0..(dados.parcelas)) do
			self.parts
			dados.data = proximo_mes(dados.data)
		end
	end
	
	def proximo_mes(mes_atual)
		dt_at = /(....).(..).(..)/.match(Date.today.to_s)
	end
end
