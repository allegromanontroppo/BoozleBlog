class PostsController < SideBarController
 
  before_filter :can_post, :only => [:new, :edit, :create, :update, :destroy]   
  before_filter :load_post!, :only => [:show, :edit, :update, :destroy]  
  before_filter :can_edit, :only => [:edit, :update, :destroy]

  # GET /posts
  def index

    @posts = Post.order("posts.created_at DESC").limit(7).includes(:comments, :user, :tags)    

  end

  # GET /posts/1
  def show
    @comments = Comment.includes(:user).find_by_post_id(@post.id)

    @comment = Comment.new
    @comment.post_id = @post.id
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.user_id = current_user.id
  end

  # GET /posts/1/edit
  def edit 
  end

  # POST /posts
  def create
    @post = Post.new(params[:post])
    @post.tags =  params[:tags_list].split(',').select{|tag| !tag.blank?}.map do |tag|
              t = Tag.new
              t.tag = tag.strip
              t
           end  

    if @post.save
      redirect_to(@post, :notice => 'Post was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
        
    @post.tags =  params[:tags_list].split(',').select{|tag| !tag.blank?}.map do |tag|
          t = Tag.new
          t.tag = tag.strip
          t
       end  
       
    if @post.update_attributes(params[:post])
      redirect_to(@post, :notice => 'Post was successfully updated.') 
    else
      render :action => "edit" 
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post.destroy
    redirect_to(posts_url) 
  end

  def add_comment

    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html { redirect_to post_path(@comment.post_id) }
        format.js
      end     
    end 

  end

private

  def can_post
    redirect_to(posts_path) unless current_user.can_post
  end

  def load_post!
    @post = Post.find(params[:id])
    redirect_to(:action => 'index') if @post.nil?
  end

  def can_edit
    redirect_to(@post) unless @post.user_id == current_user.id    
  end

end
