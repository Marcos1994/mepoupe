class Entry < ActiveRecord::Base
	has_many :parts, dependent: :destroy
	belongs_to :ctegory
	#after_create :criar_parcelas
	
	#def initialize(dados)
	#	super(dados)
		
	#end
	
	def proximo_mes(mes_atual)
		dt_at = /(....).(..).(..)/.match(Date.today.to_s)
	end
end
