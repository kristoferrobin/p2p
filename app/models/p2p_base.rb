class P2pBase < ActiveRecord::Base
	validates: user_id, uniqueness: true
	validates: card_a, presence: true, numericality: true
	validates: card_b, presence: true, numericality: true
	validates: phone, presence: true, numericality: true
	validates: expire, presence: true
	validates: cvv, presence: true, numericality: true
end
