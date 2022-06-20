# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_no_authentication

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the app, #{@user.first_name}!"
      redirect_to root_path
    else
      flash.now[:warning] = 'Unable to create such an account!'  # doesn't work for some reason :(
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :age, :password, :password_confiramtion)
  end
end
