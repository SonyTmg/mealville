class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[host_profile]
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

  def show
    @user     = current_user
    @ratings  = @user.average_rating
    @reviews  = @user.all_reviews
  end

  def host_profile
    @user     = User.find(params[:id])
    @ratings  = @user.average_rating
    @reviews  = @user.all_reviews

    @valid_user_ids = @user.confirmed_bookings_for_hosted_events.map { |booking| booking.user_id }
  end
end
