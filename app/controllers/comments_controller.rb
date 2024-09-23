class CommentsController < ApplicationController
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :set_comment, only: %i[destroy]
  before_action :authorize_user_comment, only: %i[ destroy ]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:notice] = "You created comment !"
    else
      flash[:alert] = "Comment did not create !"
    end
    redirect_to post_path(@post)
  end

  def destroy
    if @comment.destroy
      flash[:notice] = "You deleted comment !"
    else
      flash[:alert] = "Can not deleted comment !"
    end
    redirect_to post_path(@comment.post_id)
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
    if  @comment.blank?
      flash[:alert] = "Comment does not exist!"
      redirect_to root_path
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:title, :content)
    end
end
