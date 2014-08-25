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
end
