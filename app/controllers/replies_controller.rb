class RepliesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(reply_comment_params)
    @comment.user_id = current_user.id
    @comment.parent_id = params[:comment_id]

    if @comment.save
      flash[:notice] = "You created comment !"
    else
      flash[:alert] = "Comment did not create !"
    end
    redirect_to post_path(@post)
  end

  private
    def reply_comment_params
      params.require(:comment).permit(:content)
    end
end
