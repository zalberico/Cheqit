class SessionsController < ApplicationController
  #Controller for managing user sessions.
  def new
    @title = "sign in"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "sign in"
      render 'new'
    else
      sign_in user
      redirect_back_or user
    end
  end

  #Signs user out
  def destroy
    sign_out
    redirect_to root_path
  end
end
