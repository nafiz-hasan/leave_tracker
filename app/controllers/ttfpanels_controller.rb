class TtfpanelsController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_ttf, except: :user_summary #Need it to show the statistics modal for the regular user

  def index
    #@myapplications = Holiday.where(ttf_id: current_user)
    ###The necessary awesome query I came up with to find a ttf's own applications
    #@myapplications = Holiday.joins(:user).where(users: {ttf_id: current_user})
    @my_users = User.where(ttf_id: current_user)

  end

  def user_summary
    @my_user = User.find(params[:id])
    @stat = @my_user.stat
    #@user_leaves = @my_user.holidays
    @yearly_casual_leave = @stat.yearly_casual_leave
    @yearly_sick_leave = @stat.yearly_sick_leave

    @gained_casual_leave = (@yearly_casual_leave * 8.0) + @stat.carried_leave
    @gained_sick_leave = @yearly_sick_leave * 8.0

    @balance_casual_leave = @gained_casual_leave - @stat.consumed_casual_leave
    @balance_sick_leave = @gained_sick_leave - @stat.consumed_sick_leave

    respond_to do |format|
      format.html
      format.js
      format.json {render json: @my_user}
    end

  end


  def authenticate_ttf
    redirect_to '/' unless current_user.role == 'ttf'
  end

end
