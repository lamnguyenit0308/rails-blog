class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save!
      flash[:notice] = "You created comment !"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Comment did not create !"
      redirect_to post_path(@post)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:title, :content)
    end
end
