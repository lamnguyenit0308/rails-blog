class ApplicationController < ActionController::Base
  include Pundit
  include Pagy::Backend

  before_action :authenticate_user!

  respond_to :html, :json
  # allow_browser versions: :modern

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def user_not_authorized
    flash[:warning] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def authorize_post
    authorize @post
  end

  def overflow_page
    redirect_to root_path
  end
end
