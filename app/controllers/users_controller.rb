class UsersController < ApplicationController
  def become_host
    current_user.host = true
    if current_user.save
      flash[:success] = "Congratulations! You are a host now."
      redirect_to host_dashboard_path
    else
      flash[:error] = "Could not change to host"
      redirect_back fallback_location: root_path
    end
  end
end
