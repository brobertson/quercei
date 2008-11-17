class UsersController < ApplicationController
  

  # render new.rhtml
  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/choose')
      flash[:notice] = "Thanks for signing up!"
    else
      flash.now[:error] = "There was a problem with your signup: " #+ @user.errors[0]
        render :action => :new
      #redirect_to ('/signup')   
      #flash[:error] = "There was a problem with "@user.errors[0]

    end
  end

end
