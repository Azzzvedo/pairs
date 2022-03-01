class ProfilesController < ApplicationController
  # use the user model, there is no profile model
  def edit
    @profile = current_user
  end

  def update
    @profile = current_user
    if @profile.update(profile_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
