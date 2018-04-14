class Patient < ApplicationRecord
	has_many :appointments
	has_many :visits
	has_many :hospital_referrals
end
