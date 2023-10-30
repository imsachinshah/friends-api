class Friend < ApplicationRecord
	validates :name, length: {minimum: 2}
	validates :location, length: {minimum: 2}
	validates :email, length: {minimum: 2}
	validates :twitter, length: {minimum: 2}
	validates :phone, length: {is: 10}, numericality: true
end
