class Entry < ActiveRecord::Base
	has_many :parts, dependent: :destroy, autosave: true
	belongs_to :category
	
	def valor_total
		@valor = 0
		self.parts.each do |p|
			@valor += p.valor
		end
		@valor
	end
	
	def valor_efetivado
		self.valor(1)
	end
	
	def valor_pendente
		self.valor(0)
	end
	
	def valor_razao_efetivado
		((self.valor_efetivado * 100) / self.valor_total).to_i
	end
	
	def valor_razao_pendente
		((self.valor_pendente * 100) / self.valor_total).to_i
	end
	
	def valor(estado)
		@valor = 0
		self.parts.each do |p|
			if(p.confirmacao == estado)
				@valor += p.valor
			end
		end
		@valor
	end
end
