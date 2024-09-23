class CommentPolicy < ApplicationPolicy
  def destroy?
    check_author_comment
  end

  def check_author_comment
    user.present? && record.user_id == user.id
  end
end
