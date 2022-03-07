class UsersController < ApplicationController
  def toggle_host
    current_user.host = !current_user.host
    if current_user.save
      redirect_back fallback_location: root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:host)
  end
end
