class SessionsController < ApplicationController
  
  # GET /login
  def new
    #@session = Session.new 
    # POST /login に送りつけるフォームを作りたい　=> create action
    
  end
  
  # POST /login
  def create
    user = User.find_by(email: params[:session][:email])
    # user.authenticate(params[:session][:password])
    # => User object or false
    if user && user.authenticate(params[:session][:password])
      # Success
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # Failure
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end
  
  # DELETE /logout
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end
