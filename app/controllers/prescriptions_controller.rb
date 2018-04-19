class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: [:show, :edit, :update, :destroy]

  # GET /prescriptions
  # GET /prescriptions.json
  def index
    @prescriptions = Prescription.all
  end

  # GET /prescriptions/1
  # GET /prescriptions/1.json
  def show
  end

  # GET /prescriptions/new
  def new
    @prescription = Prescription.new
    @patients = Patient.all #Instance variable to Allow access to the Patient Model 
  end

  # GET /prescriptions/1/edit
  def edit
  end

  # POST /prescriptions
  # POST /prescriptions.json
  def create
    @prescription = Prescription.new(prescription_params)

    #Auto Generate Appointment based on prescription
    #Adding Records From: https://stackoverflow.com/questions/12490076/rails-3-how-to-insert-record-in-database-using-rails
    @duration = @prescription.duration
    @prescription_date = @prescription.date
    @new_visit_date = Date.parse(@prescription_date) + @duration
    @patient_name = @prescription.patient_name #Get name to search for below
    @follow_up = @prescription.follow_up

    @time = "09:30 AM"
    @visited = "False"

    if @follow_up = "True"
      @appointment = Appointment.new(:date => @new_visit_date, :time =>@time, :patient => @patient_name, :visited =>@visited)
      @appointment.save

      respond_to do |format|
        if @prescription.save
          format.html { redirect_to @prescription, notice: 'Prescription was successfully created. Follow up appointment scheduled.' }
          format.json { render :show, status: :created, location: @prescription }

        else
          format.html { render :new }
          format.json { render json: @prescription.errors, status: :unprocessable_entity }
        end
    end

    else
      respond_to do |format|
        if @prescription.save
          format.html { redirect_to @prescription, notice: 'Prescription was successfully created.' }
          format.json { render :show, status: :created, location: @prescription }

        else
          format.html { render :new }
          format.json { render json: @prescription.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # PATCH/PUT /prescriptions/1
  # PATCH/PUT /prescriptions/1.json
  def update
    respond_to do |format|
      if @prescription.update(prescription_params)
        format.html { redirect_to @prescription, notice: 'Prescription was successfully updated.' }
        format.json { render :show, status: :ok, location: @prescription }
      else
        format.html { render :edit }
        format.json { render json: @prescription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prescriptions/1
  # DELETE /prescriptions/1.json
  def destroy
    @prescription.destroy
    respond_to do |format|
      format.html { redirect_to prescriptions_url, notice: 'Prescription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prescription
      @prescription = Prescription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prescription_params
      params.require(:prescription).permit(:date, :patient_name, :medication_name, :strength, :frequency, :duration, :special_instructions, :follow_up)
    end
end
