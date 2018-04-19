require "autoappointment/version"

module Autoappointment
 def self.generate(date,time,patient_name,visited) #Method titled check to estimate which ward the patient should be allocated
      #Save parameters as instance variables
      @date = date
      @time = time
      @patient_name = patient_name
      @visited = visited

      #Generate new record from instance variables
      @appointment = Appointment.new(:date => @date, :time =>@time, :patient => @patient_name, :visited =>@visited)
      @appointment.save
 end
end