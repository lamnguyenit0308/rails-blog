class PostPolicy < ApplicationPolicy
  def destroy?
    check_author
  end

  def edit?
    check_author
  end

  def update?
    check_author
  end

  def check_author
    user.present? && record.author_id == user.id
  end
end
