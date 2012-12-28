class UsersController < LoggedInController

  before_filter :load_user, :only => :show

  def show
  end
  
  def my_account
    @user = User.find(current_user)
  end

  def update
    
    user = User.find(current_user)    
    if user.update_attributes(params[:user])
      redirect_to posts_path, :notice => "Account settings saved"
    else
      render :action => "my_account"
    end
    
  end


private 

  def load_user
     @user = User.find(params[:id])
     redirect_to(:action => 'index') if @user.nil? 
  end

end
