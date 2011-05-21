class UsersController < LoggedInController

  before_filter :load_user, :only => [:show, :edit]

  def index
  	 @users = User.order('user_name')
  end

  def show
    @comments = Comment.find_by_user_id(@user.id);
  end

  def edit
  end

  def update
  end

private 

  def load_user
     @user = User.find(params[:id])
     redirect_to(:action => 'index') if @user.nil? 
  end

end
