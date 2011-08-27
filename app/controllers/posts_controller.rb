class PostsController < SideBarController  
 
  before_filter :can_post, :only => [:new, :edit, :create, :update, :destroy]   
  before_filter :load_post!, :only => [:show, :edit, :update, :destroy]  
  before_filter :can_edit, :only => [:edit, :update, :destroy]
  
  # GET /posts
  def index

    @latest_post = Post.latest
    teaser_posts = Post.teasers
    @teaser_posts = []
    until teaser_posts.length == 0
      @teaser_posts << teaser_posts.slice!(0,2)
    end 

  end

  # GET /posts/1
  def show
    
    @comments = Comment.find_by_post @post
    @comment = Comment.new :post_id => @post.id
    
  end

  # GET /posts/new
  def new
    @post = Post.new :user_id => current_user.id

    @post.images = []
    10.times { |i| @post.images << Image.new }
  end

  # GET /posts/1/edit
  def edit 
  end

  # POST /posts
  def create
    
    post = Post.new params[:post] 
    post.user_id = current_user.id

    post.tags = params[:tags_list].split(',').select{ |tag| !tag.blank? }.map do |tag|
      Tag.new :tag => tag.strip
    end  
    
    post.videos = posted_videos(params)

    post.images = posted_photos(params)

    if post.save
      redirect_to post, :notice => 'Post was successfully created.'
    else  
      flash[:error] = @post.errors.full_messages.to_sentence unless @post.errors.empty?
      render :action => "new"
    end
    
  end


  # PUT /posts/1
  # PUT /posts/1.xml
  def update
        
    @post.tags = params[:tags_list].split(',').select{ |tag| !tag.blank? }.map do |tag|
        Tag.new :tag => tag.strip 
     end  

    @post.videos = posted_videos(params)

    @post.images = posted_photos(params)    
       
    if @post.update_attributes params[:post] 
      redirect_to @post, :notice => "#{@post.title} was successfully updated."
    else      
      flash[:error] = @post.errors.full_messages.to_sentence unless @post.errors.empty?
      render :action => "edit" 
    end
    
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_path)  }
      format.js 
    end
    
  end

  def add_comment

    @comment = Comment.new params[:comment]
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
    @post = Post.includes(:comments, :user, :tags, :videos, :images).find(params[:id])
    redirect_to(:action => 'index') if @post.nil?
  end

  def can_edit
    redirect_to(@post) unless @post.user_id == current_user.id
  end

  def posted_videos(params)

    videos = params.select{ |key, value| key.to_sym == :video && !value.blank? }

    if videos.is_a? Hash

      videos.values.map do |value|
        Video.new :embed => value.strip
      end

    elsif videos.is_a? Array

      videos.map do |value|
        Video.new :embed => value[1].strip;
      end

    end       

  end

  def posted_photos(params)

    photos = params.select{ |key, value| key.starts_with?("photo") && !value.blank? }

    if photos.is_a? Hash

      photos.values.map do |value|
        Image.new :embed => value.strip
      end

    elsif photos.is_a? Array

      photos.map do |value|
        Image.new :embed => value[1].strip;
      end

    end       

  end

end
