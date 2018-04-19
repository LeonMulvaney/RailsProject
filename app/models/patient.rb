class Patient < ApplicationRecord
	has_many :appointments
	has_many :visits
	has_many :hospital_referrals

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			Patient.create! row.to_hash
		end
	end
end
