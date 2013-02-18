class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
  	@users = User.find(params[:id])
  end
  
end
