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
      redirect_to @post, notice: "Bài viết đã được tạo thành công."
    else
      puts "12312312"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :status, :cover_photo_link)
  end
end
