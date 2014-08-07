class Entry < ActiveRecord::Base
	has_many :parts, dependent: :destroy
	belongs_to :ctegory
end
