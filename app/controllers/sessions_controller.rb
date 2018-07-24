class SessionsController < ApplicationController
  def new
  end

  def show
  end

  def create
    user = User.find_by_email(params[:email])
    flash[:notice] = 'Enter correct email and password.' if user.nil?
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to products_path
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
