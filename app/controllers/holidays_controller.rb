class HolidaysController < ApplicationController
  before_action :set_holiday, only: [:show, :edit, :update, :destroy, :accept, :reject, :approve,
                                     :current_user_holiday?, :current_ttf_holiday?,
                                     :get_holiday_status]
  after_action :save_range, only: :create
  before_action :authenticate_user!
  before_action :store_return_to, only: :authenticate_user!

  helper_method :current_user_holiday?
  helper_method :current_ttf_holiday?
  helper_method :get_holiday_status

  # GET /holidays
  # GET /holidays.json
  def index
    @holidays = current_user.holidays
  end

  # GET /holidays/1
  # GET /holidays/1.json
  def show

    unless current_user == @holiday.user || current_user == @holiday.user.ttf
      flash[:notice] = "You are not authorized to access this page"
      redirect_to root_path
    end

    @days = @holiday.days

  end

  # GET /holidays/new
  def new
    @holiday = current_user.holidays.build

  end

  # GET /holidays/1/edit
  def edit
  end

  # POST /holidays
  # POST /holidays.json
  def create
    @holiday = current_user.holidays.build(holiday_params)

    respond_to do |format|
      if @holiday.save
        #NotificationMailer.leave_request(@holiday).deliver_later
        format.html { redirect_to @holiday, notice: 'Holiday was successfully created.' }
        format.json { render :show, status: :created, location: @holiday }
      else
        format.html { render :new }
        format.json { render json: @holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  def save_range
    if(params.has_key?(:start_date) && params.has_key?(:end_date))
      (params[:start_date]..params[:end_date]).each do |d|
        @holiday.days.create!(the_date: d)
      end
    end

    NotificationMailer.leave_request(@holiday).deliver_later

  end

  # PATCH/PUT /holidays/1
  # PATCH/PUT /holidays/1.json
  def update

    respond_to do |format|
      if @holiday.update(holiday_params)
        format.html { redirect_to @holiday, notice: 'Holiday was successfully updated.' }
        format.json { render :show, status: :ok, location: @holiday }
      else
        format.html { render :edit }
        format.json { render json: @holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holidays/1
  # DELETE /holidays/1.json
  def destroy
    @holiday.destroy
    respond_to do |format|
      format.html { redirect_to holidays_url, notice: 'Holiday was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def store_return_to
    session[:return_to] = request.url
  end

  def approve
    if params[:commit] == 'accept'
      accept
    elsif params[:commit] == 'reject'
      reject
    end
  end

  def accept

    update_stats_for_acceptance(@holiday)
    @holiday.status = "Approved"
    @holiday.feedback = params[:feedback]

    if @holiday.save
      NotificationMailer.leave_confirmation(@holiday).deliver_later
      redirect_to @holiday
    end
  end

  def reject

    update_stats_for_rejection(@holiday)
    @holiday.status = "Rejected"
    @holiday.feedback = params[:feedback]

    if @holiday.save
      NotificationMailer.leave_rejection(@holiday).deliver_later
      redirect_to @holiday
    end

  end

  def update_stats_for_acceptance(holiday)

    @this = holiday
    @this_type = @this.holiday_type.downcase
    @this_status = @this.status.downcase
    @this_user_stat = @this.user.stat
    @this_days = @this.days

    @total_hours = 0
    @this_days.each do |d|
      @total_hours += d[:hours]
    end

    if @this_type == 'casual'
      @this_user_stat.consumed_casual_leave += @total_hours
    elsif @this_type == 'sick'
      @this_user_stat.consumed_sick_leave += @total_hours
    end

    @this_user_stat.save

  end


  def update_stats_for_rejection(holiday)

    @this = holiday
    @this_type = @this.holiday_type.downcase
    @this_status = @this.status.downcase
    @this_user_stat = @this.user.stat
    @this_days = @this.days

    @total_hours = 0
    @this_days.each do |d|
      @total_hours += d[:hours]
    end

    unless @this_status == 'pending'
      if @this_type == 'casual'
        @this_user_stat.consumed_casual_leave -= @total_hours
      elsif @this_type == 'sick'
        @this_user_stat.consumed_sick_leave -= @total_hours
      end
    end

    @this_user_stat.save
  end


  def current_ttf_holiday?
    current_user == @holiday.user.ttf
  end

  def current_user_holiday?
    current_user == @holiday.user
  end

  def get_holiday_status
    @holiday.status.downcase
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_holiday
      @holiday = Holiday.find(params[:id])
      @days = @holiday.days
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def holiday_params
      params.require(:holiday).permit(:reason, :description, :holiday_type, days_attributes: [:id, :the_date, :hours, :_destroy])
    end
end
