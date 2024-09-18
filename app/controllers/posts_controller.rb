class PostsController < ApplicationController
  layout "post"
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :set_post, only: %i[show edit update destroy]
  def index
    puts session
    @posts = Post.published.or(Post.where(author_id: current_user.id)).includes([ :user ]).includes([ :cover_photo_link_attachment ])
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    post_params[:status] = post_params[:status].to_i
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = "You created post !"
      redirect_to @post
    else
      flash[:alert] = "Post did not create !"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @post
  end

  def update
    if post_params[:cover_photo_link].nil?
      @post.cover_photo_link.purge
    end
    post_params[:status] = post_params[:status].to_i
    if @post.update(post_params)
      flash[:notice] = "You updated post !"
      redirect_to @post
    else
      flash[:alert] = "Post did not update !"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post
    @post.destroy
    if @post.destroy
      flash[:notice] = "You deleted post !"
      redirect_to root_path, status: :see_other
    else
      flash[:alert] = "Can not deleted post !"
      redirect_to referrer, status: :unprocessable_entity
    end
  end

  def set_post
    @post = Post.find_by(id: params[:id])
    if  @post.blank?
      flash[:alert] = "Post does not exist!"
      redirect_to root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :status, :cover_photo_link)
  end

  def user_not_authorized
    flash[:warning] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
