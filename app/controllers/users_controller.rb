class UsersController < LoggedInController

  before_filter :load_user, :only => [:show, :edit]

  def index
  	 @users = User.order('user_name')
  end

  def show
    @posts = Post.where(:id => 0) # Post.where(:user_id => @user.id).order('created_at desc').includes(:comments, :tags)
    @comments = Comment.where(:user_id => @user.id).order('created_at desc').includes(:post)
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
