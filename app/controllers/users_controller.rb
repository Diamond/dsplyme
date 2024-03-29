class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if verify_recaptcha(model: @user, message: "Captcha failed! Are you a robot?") &&@user.save
      auto_login @user
      redirect_to :root, notice: "Signed up!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to edit_user_path(@user), notice: "Edited user account successfully!"
    else
      redirect_to edit_user_path(@user), alert: "Failed to edit user account!"
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
