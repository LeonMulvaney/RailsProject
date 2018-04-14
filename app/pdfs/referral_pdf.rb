#Use separate class to reduce clutter - This class inherits from the Prawn gem 
#Resources (Multiple Stackoverflow links) From:

#Primary Resource: 
#http://railscasts.com/episodes/153-pdfs-with-prawn-revised?autoplay=true

#Support Resources:
#https://stackoverflow.com/questions/31409818/generating-a-pdf-with-prawn-and-ruby-on-rails
#https://stackoverflow.com/questions/31910161/how-to-generate-pdf-based-on-search-using-prawn-in-ruby-on-rails

#Issues with table From: https://stackoverflow.com/questions/24455356/rails-prawn-undefined-method-table-for-prawndocument0x007fda2d594a98
#Prawn Tables From: http://prawnpdf.org/prawn-table-manual.pdf

#Prawn Documentation From: http://prawnpdf.org/manual.pdf
#Prawn Text Styling From: http://prawnpdf.org/api-docs/2.0/Prawn/Text.html 
#Prawn Images From: https://stackoverflow.com/questions/23429319/how-to-insert-image-in-pdf-using-prawn
class ReferralPdf < Prawn::Document

	def initialize(hospital_referral, patient)
		super(top_margin: 120) #Override to edit margin

		@hospital_referral = hospital_referral #Save variables from
		@patient = patient
		image "app/assets/images/hse_logo.png", :at => [0,710], :width => 200
		image "app/assets/images/customLogo.png", :at => [440,720], :width => 80

		text"Hospital Referral Form" , size: 15, style: :italic, :align => :center
		text "_____________________________________________", :align => :center

		text "Patient Details:", size: 12, style: :italic
		text "Referral Date:#{hospital_referral.date}", size: 12, style: :italic
		text "Patient Name:#{hospital_referral.patient_name}", size: 12, style: :italic
		text "Hospital Referred To:#{hospital_referral.hospital_name}",size: 12, style: :italic
		text "Reason:#{hospital_referral.referral_reason}", size: 12, style: :italic
		text "Recommended Department:#{hospital_referral.department}",size: 12, style: :italic

		text "#{patient.address}"

	end

end #End of Class
