class ApplicationController < ActionController::Base
  include Authorization
  include ErrorHandling

  private
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def user_signed_in?
    current_user.present?
  end

  def require_authentication
    return if user_signed_in?
    redirect_to root_path
  end

  def require_no_authentication
    return if !user_signed_in?
    redirect_to root_path
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete :user_id
  end

  def already_answered?
    @answers.each do |a|
       return true if a.user_id_in_database == current_user.id
    end
    false
  end


  helper_method :current_user, :user_signed_in?, :already_answered?
end