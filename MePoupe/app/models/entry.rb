class Entry < ActiveRecord::Base
	has_many :parts, dependent: :destroy, autosave: true
	belongs_to :category
	
	def proximo_mes(mes_atual)
		dt_at = /(....).(..).(..)/.match(Date.today.to_s)
	end
end
