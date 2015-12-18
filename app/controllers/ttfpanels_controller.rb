class TtfpanelsController < ApplicationController

  before_action :authenticate_ttf

  def index
    #@myapplications = Holiday.where(ttf_id: current_user)
    ###The necessary awesome query I came up with to find a ttf's own applications
    #@myapplications = Holiday.joins(:user).where(users: {ttf_id: current_user})
    @my_users = User.where(ttf_id: current_user)

  end

  def user_summary
    @my_user = User.find(params[:id])
    @user_leaves = @my_user.holidays
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
