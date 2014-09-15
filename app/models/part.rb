class Part < ActiveRecord::Base
	belongs_to :entry
	
	
	#validadores
	validates :valor, :confirmacao, presence: true
	validates :valor, numericality: {greater_than_or_equal_to: 0.00}
end
