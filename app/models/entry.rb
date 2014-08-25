class Entry < ActiveRecord::Base
	has_many :parts, dependent: :destroy, autosave: true
	belongs_to :category
end
