class Book < ApplicationRecord
	validates :title, presence: true
	belongs_to :user

	validates :body, presence: true, length: { maximum: 200 }

end
