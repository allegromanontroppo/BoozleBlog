class PostsController < SideBarController  
  
  before_filter :can_post, :only => [:new, :edit, :create, :update, :destroy]   
  before_filter :load_post!, :only => [:show, :edit, :update, :destroy, :add_comment, :remove_comment]
  before_filter :can_edit, :only => [:edit, :update, :destroy]

  # GET /posts
  def index
    
    @posts = Post.paginate(:page => params[:page], :per_page => 5).includes(:comments, :photos, :videos)
    
    return render :partial => @posts, :spacer_template => 'shared/spacer' if request.xhr?
    
  end

  # GET /posts/1
  def show
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build

    1.times { @post.videos.build }
    10.times { @post.photos.build }
  end

  # GET /posts/1/edit
  def edit 
    1.times { @post.videos.build }
    10.times { @post.photos.build }
  end

  # POST /posts
  def create
    
    @post = current_user.posts.build params[:post] 
    params[:tags_list].split(',').select(&:present?).map(&:strip).each do |tag|
      @post.tags.build :tag => tag
    end  
  
    if @post.save
      redirect_to @post, :notice => "#{@post.title} was created."
    else  
      flash[:error] = @post.errors.full_messages.to_sentence 
      render :action => 'new'
    end
    
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
        
    params[:tags_list].split(',').select(&:present?).map(&:strip).each do |tag|
      @post.tags.find_or_create_by_tag tag
    end
   
    if @post.update_attributes params[:post] 
      redirect_to @post, :notice => "#{@post.title} was updated."
    else      
      flash[:error] = @post.errors.full_messages.to_sentence
      render url_for(:action => 'edit') 
    end
    
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    
    @post.destroy
    redirect_to posts_path, :notice => "#{ @post.title } deleted"
    
  end
  
  def add_comment
    
    if @comment = @post.comments.create(:body => params[:comment][:body], :user => current_user)
      
      if request.xhr?
        render :partial => 'posts/comment', :object => @comment
      else
        redirect_to @post, :notice => 'Comment added'
      end
      
    else
      
      if request.xhr?
        render :json => @comment, :status => 400
      else
        render 'show'
      end
      
    end
    
  end
  
  def remove_comment
    
    comment = @post.comments.find params[:comment_id]
    comment.delete if comment.allowed_to_delete?(current_user)
    
    if request.xhr?
      render :nothing => true
    else  
      redirect_to @post, :notice => 'Comment deleted'
    end
    
  end

private

  def can_post
    redirect_to posts_path unless current_user.can_post
  end

  def load_post!
    @post = Post.includes(:comments, :user, :tags, :videos, :photos).find(params[:id])
  end

  def can_edit
    redirect_to @post unless @post.user_id == current_user.id
  end

end
