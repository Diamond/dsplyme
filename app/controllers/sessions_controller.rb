class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      redirect_to :root, notice: "Logged in!"
    else
      flash.now.alert = "Username or Password was invalid"
    end
  end

  def destroy
    logout
    redirect_to :root, notice: "Logged out!"
  end
end
