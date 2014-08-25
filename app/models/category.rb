class Category < ActiveRecord::Base
	has_many :entries, dependent: :destroy
	belongs_to :user
	has_many :goals
end
