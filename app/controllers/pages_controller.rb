class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home, raise: false

  def home; end

  def profile
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to my_profile_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :photo, :reset_password_token, :email, :address, :gender, :bio, :birth_date, :competitiveness)
  end

end
