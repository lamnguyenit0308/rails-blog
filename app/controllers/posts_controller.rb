class PostsController < ApplicationController
  layout "post"
  def index
    @posts = Post.published
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    post_params[:status] = post_params[:status].to_i
    user = current_user
    @post = user.posts.build(post_params)

    if @post.save
      flash[:notice] = "You created post !"
      redirect_to @post
    else
      flash[:notice] = "Post didn't create !"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if post_params[:cover_photo_link].nil?
      @post.cover_photo_link.purge
    end
    if @post.update(post_params)
      flash[:notice] = "You updated post !"
      redirect_to @post
    else
      flash[:notice] = "Post didn't update !"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "You deleted post !"
    redirect_to root_path, status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :status, :cover_photo_link)
  end
end
