class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @message = "Welcome " + current_user.name
  end
end
